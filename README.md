# TableTies

TableTies is an app that connects strangers over dinner based on shared interests. Each person is paired with 8 others who have similar interests. Our goal is to make it easier to form new friendships, whether you're visiting, new to town, or a long-time resident. We're on a mission to address the loneliness epidemic by facilitating quality connections in an era where forming lasting relationships has become increasingly challenging.

## Table of Contents

- [Architecture](#architecture)
- [Libraries and Techniques](#libraries-and-techniques)
- [Setup and Common Issues](#setup-and-common-issues)

## Architecture

### Flutter BLoC Pattern

We utilize the [BLoC (Business Logic Component) architecture](https://pub.dev/packages/flutter_bloc) to manage state and handle user interactions effectively in our Flutter app.

#### Core Principles

1. **Events**: Represent user interactions or triggers that initiate actions within the app.
2. **Bloc**: Acts as the central logic unit, handling events, interacting with repositories, and emitting new states.
3. **Repositories**: Encapsulate logic for interacting with external data sources.
4. **States**: Represent the current state of the app or specific parts of it.

#### Mental Model

1. User Interaction: The user interacts with the UI, triggering an event.
2. Event Dispatch: The UI dispatches the event to the relevant BLoC.
3. Bloc Processing: The BLoC receives the event, interacts with repositories if needed, performs logic, and handles errors.
4. State Emission: The BLoC emits a new state based on the processing outcome.
5. UI Update: The UI, listening to the BLoC's state stream, receives the new state and rebuilds itself accordingly.

## Libraries and Techniques

(Add information about key libraries and techniques used in the project)

## Setup and Common Issues

### Supabase Configuration

When working with Supabase, pay close attention to the default status of fields and their expected values. Most Supabase-related errors can be resolved by double-checking these configurations.

### Known Issues and Solutions

(Add any known issues and their solutions here)

## Contributing

(Add information about how to contribute to the project)

## License

(Add license information)