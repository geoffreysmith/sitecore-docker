$cert = New-SelfSignedCertificate -certstorelocation cert:\localmachine\my -dnsname 'sitecore-docker-devonly' -KeyUsage DigitalSignature,CertSign -KeyExportPolicy Exportable -Provider "Microsoft Strong Cryptographic Provider" `
-HashAlgorithm "SHA256";
$pwd = ConvertTo-SecureString -String 'secret' -Force -AsPlainText;
Export-PfxCertificate -cert $cert -FilePath '.\Files\root.pfx' -Password $pwd;

.\Generate-Self-Signed-Certificate.ps1 -dnsName 'xconnect.client' -file '.\Files\xconnect-client.pfx' -secret 'secret' -signer $cert
.\Generate-Self-Signed-Certificate.ps1 -dnsName 'xconnect' -file '.\Files\xconnect-ssl.pfx' -secret 'secret' -signer $cert
.\Generate-Self-Signed-Certificate.ps1 -dnsName 'sitecore' -file '.\Files\sitecore.pfx' -secret 'secret' -signer $cert
.\Generate-Self-Signed-Certificate.ps1 -dnsName 'commerce.client' -file '.\Files\commerce.pfx' -secret 'secret' -signer $cert
.\Generate-Self-Signed-Certificate.ps1 -dnsName 'identity' -file '.\Files\identity.pfx' -signer $cert
