$cert = New-SelfSignedCertificate -Subject "Dannys certifikat” -Type CodeSigningCert -CertStoreLocation Cert:\LocalMachine\My
Export-Certificate -Cert $cert -FilePath C:\temp\rootcert.crt
Import-Certificate -CertStoreLocation Cert:\LocalMachine\Root -FilePath C:\temp\rootcert.crt
# cd Cert:\CurrentUser\Root
# ls
'This is a certificate' | Out-File -FilePath C:\temp\rootcert.ps1
Set-AuthenticodeSignature -FilePath C:\temp\rootcert.ps1 -Certificate $cert

$cert