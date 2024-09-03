class InterestsState {
  final List<String> selectedInterests;
  final String? errorMessage;
  final Map<String, List<String>> availableInterests = {
    'Outdoor': ['Hiking', 'Running', 'Camping', 'Biking', 'Swimming'],
    'Creative': ['Painting', 'Photography', 'Writing', 'Music', 'DIY'],
    'Tech': ['Coding', 'Gaming', 'AI', 'VR', 'Gadgets'],
  };

  InterestsState({required this.selectedInterests, this.errorMessage});

  InterestsState copyWith(
      {List<String>? selectedInterests, String? errorMessage}) {
    return InterestsState(
      selectedInterests: selectedInterests ?? this.selectedInterests,
      errorMessage: errorMessage,
    );
  }
}
