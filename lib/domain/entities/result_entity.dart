/// Wrapper pour les résultats avec support d'erreur et de chargement
/// Pattern moderne pour la gestion d'état
sealed class ResultEntity<T> {
  const ResultEntity();

  /// Crée un résultat de succès
  const factory ResultEntity.success(T data) = SuccessResult<T>;

  /// Crée un résultat d'erreur
  const factory ResultEntity.error(
    String message, {
    Object? error,
    StackTrace? stackTrace,
  }) = ErrorResult<T>;

  /// Crée un résultat de chargement
  const factory ResultEntity.loading() = LoadingResult<T>;

  /// Vérifie si c'est un succès
  bool get isSuccess => this is SuccessResult<T>;

  /// Vérifie si c'est une erreur
  bool get isError => this is ErrorResult<T>;

  /// Vérifie si c'est un chargement
  bool get isLoading => this is LoadingResult<T>;

  /// Obtient les données si c'est un succès
  T? get dataOrNull {
    return switch (this) {
      SuccessResult<T>(:final data) => data,
      _ => null,
    };
  }

  /// Obtient l'erreur si c'est une erreur
  String? get errorOrNull {
    return switch (this) {
      ErrorResult<T>(:final message) => message,
      _ => null,
    };
  }

  /// Transforme les données
  ResultEntity<R> map<R>(R Function(T data) transform) {
    return switch (this) {
      SuccessResult<T>(:final data) => ResultEntity.success(transform(data)),
      ErrorResult<T>(:final message, :final error, :final stackTrace) =>
        ResultEntity.error(message, error: error, stackTrace: stackTrace),
      LoadingResult<T>() => ResultEntity.loading(),
    };
  }

  /// Exécute une fonction selon le type de résultat
  R when<R>({
    required R Function(T data) success,
    required R Function(String message, Object? error, StackTrace? stackTrace) error,
    required R Function() loading,
  }) {
    return switch (this) {
      SuccessResult<T>(:final data) => success(data),
      ErrorResult<T>(:final message, :final error, :final stackTrace) =>
        error(message, error, stackTrace),
      LoadingResult<T>() => loading(),
    };
  }
}

/// Résultat de succès avec données
class SuccessResult<T> extends ResultEntity<T> {
  final T data;

  const SuccessResult(this.data);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SuccessResult<T> && other.data == data;
  }

  @override
  int get hashCode => data.hashCode;

  @override
  String toString() => 'SuccessResult(data: $data)';
}

/// Résultat d'erreur
class ErrorResult<T> extends ResultEntity<T> {
  final String message;
  final Object? error;
  final StackTrace? stackTrace;

  const ErrorResult(this.message, {this.error, this.stackTrace});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ErrorResult<T> &&
        other.message == message &&
        other.error == error &&
        other.stackTrace == stackTrace;
  }

  @override
  int get hashCode => Object.hash(message, error, stackTrace);

  @override
  String toString() => 'ErrorResult(message: $message, error: $error)';
}

/// Résultat de chargement
class LoadingResult<T> extends ResultEntity<T> {
  const LoadingResult();

  @override
  bool operator ==(Object other) {
    return identical(this, other) || other is LoadingResult<T>;
  }

  @override
  int get hashCode => 0;

  @override
  String toString() => 'LoadingResult()';
}

/// Extension pour Future
extension FutureResultExtension<T> on Future<T> {
  /// Convertit un Future en Future<ResultEntity>
  Future<ResultEntity<T>> toResult() async {
    try {
      final data = await this;
      return ResultEntity.success(data);
    } catch (error, stackTrace) {
      return ResultEntity.error(
        error.toString(),
        error: error,
        stackTrace: stackTrace,
      );
    }
  }
}

/// Extension pour ResultEntity
extension ResultEntityExtension<T> on ResultEntity<T> {
  /// Exécute une action sur les données si c'est un succès
  void ifSuccess(void Function(T data) action) {
    if (this is SuccessResult<T>) {
      action((this as SuccessResult<T>).data);
    }
  }

  /// Exécute une action sur l'erreur si c'est une erreur
  void ifError(void Function(String message, Object? error) action) {
    if (this is ErrorResult<T>) {
      final errorResult = this as ErrorResult<T>;
      action(errorResult.message, errorResult.error);
    }
  }

  /// Transforme en nullable
  T? toNullable() {
    return switch (this) {
      SuccessResult<T>(:final data) => data,
      _ => null,
    };
  }
}