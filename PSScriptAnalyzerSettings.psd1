@{
    Severity=@('Error','Warning')
    # IncludeRules = @()
    ExcludeRules = @(
        'PSAvoidUsingUserNameAndPassWordParams',
        'PSAvoidUsingPlainTextForPassword'
    )
}
