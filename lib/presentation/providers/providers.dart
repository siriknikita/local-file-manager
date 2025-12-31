import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:local_file_manager/data/datasources/local_file_datasource.dart';
import 'package:local_file_manager/data/platform/platform_file_service.dart';
import 'package:local_file_manager/data/platform/platform_file_service_factory.dart';
import 'package:local_file_manager/data/repositories/file_repository_impl.dart';
import 'package:local_file_manager/domain/repositories/file_repository.dart';

/// Provider for the platform file service.
final platformFileServiceProvider = Provider<PlatformFileService>((ref) {
  return PlatformFileServiceFactory.create();
});

/// Provider for the local file data source.
final localFileDataSourceProvider = Provider<LocalFileDataSource>((ref) {
  final platformService = ref.watch(platformFileServiceProvider);
  return LocalFileDataSource(platformService);
});

/// Provider for the file repository.
final fileRepositoryProvider = Provider<FileRepository>((ref) {
  final dataSource = ref.watch(localFileDataSourceProvider);
  return FileRepositoryImpl(dataSource);
});

