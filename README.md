#### TableTies

Table Ties is an app that allows strangers to meet other strangers over dinner based on their intrests. each person is paird with 8 other peaople who share the same intrests. the goal is to make it easier to make new friends regardless if your visiting, new to town or a native. We are on a mission to cure the lonelyness epidemic because we all want quality freinds but it seams as thouth lately its become much more difficult to make new lasting and quality connections.  

Below is a breakdown of this codebase, the libraries and techniques we use also the gotcha's you may encounter. mostly due to our own techdebt lol. But still this readme is mean to get you up and running while helping you fix most of the problems you may run into during set up. 

# Architecture. 

## [How We Use Flutter BLoC in Our App](https://pub.dev/packages/flutter_bloc)

In our Flutter app, we leverage the BLoC (Business Logic Component) architecture to manage state and handle user interactions effectively.

Core Principles
Events: Events represent user interactions or other triggers that initiate actions within the app. They are defined in separate event classes and dispatched to the BLoC.
Bloc: The BLoC acts as the central logic unit, handling incoming events, interacting with repositories for data fetching or manipulation, and emitting new states based on the outcomes of these operations.
Repositories: Repositories encapsulate the logic for interacting with external data sources, abstracting the data access details from the BLoC.
States: States represent the current state of your app or a specific part of it. They are emitted by the BLoC in response to events and are used by the UI to render the appropriate content or trigger actions.
Mental Model
User Interaction: The user interacts with the UI, triggering an event.
Event Dispatch: The UI dispatches the event to the relevant BLoC.
Bloc Processing: The BLoC receives the event, interacts with repositories if needed, performs logic, and handles errors.
State Emission: The BLoC emits a new state based on the processing outcome.
UI Update: The UI, listening to the BLoC's state stream, receives the new state and rebuilds itself accordingly.


On supabase make sure you are checking the default status of fields and also their expected value. most supabase errors can be fixed this way. 