function proposeSkip($step) {
  $shouldSkip = Read-Host -Prompt "The next step is $step. To skip enter 'skip'"
  if ($shouldSkip -eq "skip") {
    exit
  }
}
