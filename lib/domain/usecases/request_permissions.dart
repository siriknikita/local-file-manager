import 'package:local_file_manager/data/services/permission_service.dart';

/// Use case for requesting storage permissions from the user.
///
/// This use case requests the necessary storage permissions
/// needed for file operations.
class RequestPermissions {
  /// Creates a new [RequestPermissions] use case.
  ///
  /// [permissionService] The permission service to use for requesting permissions.
  const RequestPermissions(this.permissionService);

  /// The permission service instance.
  final PermissionService permissionService;

  /// Executes the request permissions operation.
  ///
  /// Returns true if permissions were granted, false otherwise.
  Future<bool> call() {
    return permissionService.requestStoragePermission();
  }
}

