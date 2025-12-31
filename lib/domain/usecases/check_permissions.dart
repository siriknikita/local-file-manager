import 'package:local_file_manager/data/services/permission_service.dart';

/// Use case for checking if storage permissions are granted.
///
/// This use case checks the current status of storage permissions
/// needed for file operations.
class CheckPermissions {
  /// Creates a new [CheckPermissions] use case.
  ///
  /// [permissionService] The permission service to use for checking permissions.
  const CheckPermissions(this.permissionService);

  /// The permission service instance.
  final PermissionService permissionService;

  /// Executes the check permissions operation.
  ///
  /// Returns true if storage permissions are granted, false otherwise.
  Future<bool> call() {
    return permissionService.checkStoragePermission();
  }
}

