
Describe 'Connect-SnipeitPS' {
    $SnipeitDev = 'https://develop.snipeitapp.com/'
    $SnipeitKey = 'UqddVx6SDb3HLw1Pmw1wGGYHA6w8wWQAiS9kg2xMcz5i75HOULaN3miqYvcPCvHpI2CBfuvdplI8QNm_XzFPmoQRu_5kR8knzla4'
    $SnipeitSecKey = ConvertTo-SecureString -Force -AsPlainText -String $SnipeitKey
    $SnipeSiteCred =  New-Object -Type PSCredential -Argumentlist $SnipeitDev,$SnipeitSecKey

    It 'Should connect to api with url and api key' {
        Connect-SnipeitPS -url $SnipeitDev -apiKey $SnipeitKey | Should -Not Throw
    }

    It 'Should connect to api with url and secureapi key' {
        Connect-SnipeitPS -url $SnipeitDev -secureApiKey $SnipeitSecKey | Should -Not Throw
    }

    It 'Should connect to api with siteCred' {
        Connect-SnipeitPS -siteCred $SnipeSiteCred | Should -Not Throw
    }
}
