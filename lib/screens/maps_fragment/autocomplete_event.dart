abstract class AutocompleteEvent {
  const AutocompleteEvent();

  List<Object> get props => [];
}

class LoadAutocomplete extends AutocompleteEvent {
  final String searchInput;

  LoadAutocomplete({this.searchInput = ''});

  @override
  List<Object> get props => [searchInput];
}
