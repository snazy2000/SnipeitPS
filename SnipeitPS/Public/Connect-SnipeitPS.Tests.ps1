$script:SnipeitDev = 'https://develop.snipeitapp.com/'
$script:SnipeitKey = 'UqddVx6SDb3HLw1Pmw1wGGYHA6w8wWQAiS9kg2xMcz5i75HOULaN3miqYvcPCvHpI2CBfuvdplI8QNm_XzFPmoQRu_5kR8knzla4'
$script:SnipeitSecKey = ConvertTo-SecureString -Force -AsPlainText -String $SnipeitKey
$script:SnipeSiteCred =  New-Object -Type PSCredential -Argumentlist $SnipeitDev,$SnipeitSecKey

Describe 'Connect-SnipeitPS' {
    Context "Connections" {

        It 'Should connect to api with url and api key' {
            Connect-SnipeitPS -url $script:SnipeitDev -apiKey $script:SnipeitKey | Should -Not Throw
        }

        It 'Should connect to api with url and secureapi key' {
            Connect-SnipeitPS -url $script:SnipeitDev -secureApiKey $script:SnipeitSecKey | Should -Not Throw
        }

        It 'Should connect to api with siteCred' {
        Connect-SnipeitPS -siteCred $script:SnipeSiteCred | Should -Not Throw
        }
    }
}
