@(
    @{ResourceGroupName="rg-dev-functionapp-001": SName = "sadevfunctionapp"}
) | ForEach-Object {
    write-Host $._SName
        (invoke-pester @{Path='./storage.ps1';Parameters=@{}} -OutputFile ("Test-{0}.xml" -f $_.SName) -OutputFormat NUnitXML -PassThru)

}
