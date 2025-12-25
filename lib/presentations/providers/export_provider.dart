import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/export_data_entity.dart';
import '../../data/repositories/export_repository_impl.dart';
import '../providers/app_providers.dart';
import '../providers/day_provider.dart';
import '../providers/settings_provider.dart';

/// État pour les exports
class ExportState {
  final List<ExportDataEntity> exports;
  final bool isLoading;
  final String? error;
  final Map<String, dynamic>? stats;

  const ExportState({
    required this.exports,
    this.isLoading = false,
    this.error,
    this.stats,
  });

  ExportState copyWith({
    List<ExportDataEntity>? exports,
    bool? isLoading,
    String? error,
    Map<String, dynamic>? stats,
  }) {
    return ExportState(
      exports: exports ?? this.exports,
      isLoading: isLoading ?? this.isLoading,
      error: error,
      stats: stats ?? this.stats,
    );
  }

  ExportDataEntity? getLastExport() {
    if (exports.isEmpty) return null;
    return exports.reduce((a, b) => a.exportDate.isAfter(b.exportDate) ? a : b);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ExportState &&
        const ListEquality().equals(other.exports, exports) &&
        other.isLoading == isLoading &&
        other.error == error &&
        const MapEquality().equals(other.stats, stats);
  }

  @override
  int get hashCode {
    return Object.hash(
      const ListEquality().hash(exports),
      isLoading,
      error,
      const MapEquality().hash(stats),
    );
  }
}

/// Notifier pour les exports
class ExportNotifier extends StateNotifier<ExportState> {
  final ExportRepositoryImpl _repository;
  final Ref _ref;

  ExportNotifier(this._repository, this._ref)
      : super(ExportState(
          exports: [],
        )) {
    _loadExports();
  }

  // Charger tous les exports
  Future<void> _loadExports() async {
    state = state.copyWith(isLoading: true, error: null);
    
    final result = await _repository.getAllExports();
    
    result.when(
      success: (exports) {
        state = state.copyWith(
          exports: exports,
          isLoading: false,
        );
        _loadStats();
      },
      error: (message, error, stackTrace) {
        state = state.copyWith(
          isLoading: false,
          error: message,
        );
        _ref.setError(message);
      },
      loading: () {
        state = state.copyWith(isLoading: true);
      },
    );
  }

  // Créer un nouvel export
  Future<void> createExport() async {
    final dayState = _ref.read(dayProvider);
    final settingsState = _ref.read(settingsProvider);
    
    final export = ExportDataEntity.create(
      year: 2026,
      days: dayState.days,
      settings: settingsState.settings,
    );
    
    final result = await _repository.saveExport(export);
    
    result.when(
      success: (key) {
        final newExports = List<ExportDataEntity>.from(state.exports)..add(export);
        state = state.copyWith(exports: newExports);
        _loadStats();
        
        // Mettre à jour la date de dernière sauvegarde
        final settingsNotifier = _ref.read(settingsProvider.notifier);
        settingsNotifier.updateLastBackupDate(DateTime.now());
        
        _ref.setSuccess('Export créé avec succès');
      },
      error: (message, error, stackTrace) {
        _ref.setError(message);
      },
      loading: () {},
    );
  }

  // Sauvegarder un export avec clé
  Future<void> saveExportWithKey(String key, ExportDataEntity export) async {
    final result = await _repository.saveExportWithKey(key, export);
    
    result.when(
      success: (_) {
        final newExports = List<ExportDataEntity>.from(state.exports);
        final index = newExports.indexWhere((e) => 
          e.exportDate.isAtSameMomentAs(export.exportDate)
        );
        
        if (index != -1) {
          newExports[index] = export;
        } else {
          newExports.add(export);
        }
        
        state = state.copyWith(exports: newExports);
        _loadStats();
        _ref.setSuccess('Export sauvegardé');
      },
      error: (message, error, stackTrace) {
        _ref.setError(message);
      },
      loading: () {},
    );
  }

  // Exporter en JSON
  Future<String?> exportToJson(ExportDataEntity export) async {
    final result = await _repository.exportToJson(export);
    
    return result.when(
      success: (jsonString) {
        _ref.setSuccess('Export JSON généré');
        return jsonString;
      },
      error: (message, error, stackTrace) {
        _ref.setError(message);
        return null;
      },
      loading: () => null,
    );
  }

  // Importer depuis JSON
  Future<ExportDataEntity?> importFromJson(String jsonString) async {
    final result = await _repository.importFromJson(jsonString);
    
    return result.when(
      success: (export) {
        final newExports = List<ExportDataEntity>.from(state.exports)..add(export);
        state = state.copyWith(exports: newExports);
        _loadStats();
        _ref.setSuccess('Import réussi');
        return export;
      },
      error: (message, error, stackTrace) {
        _ref.setError(message);
        return null;
      },
      loading: () => null,
    );
  }

  // Supprimer un export
  Future<void> deleteExport(String key) async {
    final result = await _repository.deleteExport(key);
    
    result.when(
      success: (_) {
        final newExports = state.exports.where((e) => e.exportDate.toString() != key).toList();
        state = state.copyWith(exports: newExports);
        _loadStats();
        _ref.setSuccess('Export supprimé');
      },
      error: (message, error, stackTrace) {
        _ref.setError(message);
      },
      loading: () {},
    );
  }

  // Effacer tous les exports
  Future<void> clearAllExports() async {
    final result = await _repository.clearAllExports();
    
    result.when(
      success: (_) {
        state = state.copyWith(exports: []);
        _loadStats();
        _ref.setSuccess('Tous les exports ont été effacés');
      },
      error: (message, error, stackTrace) {
        _ref.setError(message);
      },
      loading: () {},
    );
  }

  // Charger les statistiques
  Future<void> _loadStats() async {
    final result = await _repository.getExportStats();
    
    result.when(
      success: (stats) {
        state = state.copyWith(stats: stats);
      },
      error: (message, error, stackTrace) {
        debugPrint('Erreur lors du chargement des stats: $message');
      },
      loading: () {},
    );
  }

  // Rechercher des exports
  Future<List<ExportDataEntity>> searchExports({
    int? year,
    DateTime? startDate,
    DateTime? endDate,
    String? version,
  }) async {
    final result = await _repository.searchExports(
      year: year,
      startDate: startDate,
      endDate: endDate,
      version: version,
    );
    
    return result.when(
      success: (exports) => exports,
      error: (message, error, stackTrace) {
        _ref.setError(message);
        return [];
      },
      loading: () => [],
    );
  }

  // Générer un export CSV
  String generateCsv(ExportDataEntity export) {
    return export.toCsv();
  }

  // Vérifier si un export est valide
  bool validateExport(ExportDataEntity export) {
    try {
      final json = export.toJson();
      return json['checksum'] != null;
    } catch (e) {
      return false;
    }
  }

  // Obtenir le dernier export
  ExportDataEntity? getLastExport() {
    return state.getLastExport();
  }

  // Vérifier si des exports existent
  bool exportsExist() {
    return state.exports.isNotEmpty;
  }
}

/// Providers Riverpod
final exportProvider = StateNotifierProvider<ExportNotifier, ExportState>((ref) {
  final repository = ref.watch(exportRepositoryProvider);
  return ExportNotifier(repository, ref);
});

final lastExportProvider = Provider<ExportDataEntity?>((ref) {
  final state = ref.watch(exportProvider);
  return state.getLastExport();
});

final exportsExistProvider = Provider<bool>((ref) {
  final state = ref.watch(exportProvider);
  return state.exports.isNotEmpty;
});

final exportStatsProvider = Provider<Map<String, dynamic>?>((ref) {
  final state = ref.watch(exportProvider);
  return state.stats;
});