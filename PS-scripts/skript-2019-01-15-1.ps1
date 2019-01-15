# First the variable is set to create and sign a new certificate located in Cert:\LocalMachine\My
$cert = New-SelfSignedCertificate -Subject "Dannys certifikat” -Type CodeSigningCert -CertStoreLocation Cert:\LocalMachine\My

# Then it needs to be exported to a file on a file system
Export-Certificate -Cert $cert -FilePath C:\temp\rootcert.crt

# Here the certificate file is imported to the root certificate directory from the file path
Import-Certificate -CertStoreLocation Cert:\LocalMachine\Root -FilePath C:\temp\rootcert.crt

# Here the script adds content to another script because scripts with 4 bytes or less cannot be certified
'This is a certificate' | Out-File -FilePath C:\temp\rootcert.ps1

# Finally the script certifies a script with the newly create certificate
Set-AuthenticodeSignature -FilePath C:\temp\rootcert.ps1 -Certificate $cert