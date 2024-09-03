abstract class InterestsEvent {}

class AddInterest extends InterestsEvent {
  final String interest;
  AddInterest(this.interest);
}

class RemoveInterest extends InterestsEvent {
  final String interest;
  RemoveInterest(this.interest);
}
