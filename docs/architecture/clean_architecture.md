# Clean Architecture Overview

Local File Manager follows Clean Architecture principles to ensure separation of concerns, testability, and maintainability.

## Architecture Layers

The application is structured into three main layers:

```
┌─────────────────────────────────────┐
│      Presentation Layer              │
│  (UI, Widgets, Riverpod Providers)  │
└──────────────┬──────────────────────┘
               │
┌──────────────▼──────────────────────┐
│        Domain Layer                 │
│  (Entities, Use Cases, Interfaces)  │
└──────────────┬──────────────────────┘
               │
┌──────────────▼──────────────────────┐
│         Data Layer                  │
│  (Repositories, Data Sources,       │
│   Platform Services)                │
└─────────────────────────────────────┘
```

## Layer Responsibilities

### Presentation Layer
- **Location**: `lib/presentation/`
- **Responsibilities**:
  - UI components (pages, widgets)
  - State management (Riverpod providers)
  - User interactions
  - Navigation

### Domain Layer
- **Location**: `lib/domain/`
- **Responsibilities**:
  - Business logic (use cases)
  - Entity models
  - Repository interfaces
  - Platform-independent business rules

### Data Layer
- **Location**: `lib/data/`
- **Responsibilities**:
  - Repository implementations
  - Data sources
  - Platform-specific services
  - External API integration

## Dependency Rule

Dependencies flow inward:
- Presentation depends on Domain
- Data depends on Domain
- Domain has no dependencies on other layers

This ensures that business logic remains independent of UI and data implementation details.

## Benefits

1. **Testability**: Each layer can be tested independently
2. **Maintainability**: Changes in one layer don't affect others
3. **Flexibility**: Easy to swap implementations (e.g., different platform services)
4. **Scalability**: Easy to add new features without breaking existing code

