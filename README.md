# ColdFusion-Get-Certificate-Info
Get certificate information by request URL and port

The two ColdFusion components facilitate aquiring Certificate information for various end uses. 
getCertificateInfo obtains a subset of information for most purposes. 
getCertificateInfoVerbose obtains a much larger set of information 

Both take a URL and port number as input
Both return an array of one to many structs depending on the response from the server


getCertificateInfo provides the following: CheckPerformedDate CheckURL CheckDaysLeftValid CheckDaysUntilValid NotBeforeValidDate NotAfterInvalidDate SerialNumber IssuerX500Principal SubjectDN_toString IssuerDN_toString

getCertificateInfoVerbose provides the following: CheckPerformedDate CheckURL NotBeforeValidDate NotAfterInvalidDate SerialNumber SigAlgName SigAlgOID BasicConstraints Version hasUnsupportedCriticalExtension hashCode IssuerX500Principal NonCriticalExtensionOIDs_isEmpty NonCriticalExtensionOIDs_size SubjectDN_toString IssuerDN_toString CriticalExtensionOIDs_isEmpty CriticalExtensionOIDs_size KeyUsage_digitalSignature KeyUsage_nonRepudiation KeyUsage_keyEncipherment KeyUsage_dataEncipherment KeyUsage_keyAgreement KeyUsage_keyCertSign KeyUsage_cRLSign KeyUsage_encipherOnly KeyUsage_decipherOnly PublicKey_binary EncryptEngine TBSCertificate


information on the actual data provided can be found in the specification
      
      Internet X.509 Public Key Infrastructure Certificate and Certificate Revocation List (CRL) Profile
           https://tools.ietf.org/html/rfc5280 
