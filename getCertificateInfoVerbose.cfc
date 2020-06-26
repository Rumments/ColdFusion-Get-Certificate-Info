<cfcomponent>
	<cffunction name="getAllCertificateData" output="false" >
		<cfargument name="URL" required="yes" type="string" > 
		<cfargument name="port" required="yes" type="numeric" >  
		<cfscript>
			URL = lcase(trim(URL));
			URL = Replace(URL, 'https://', '');
			URL = Replace(URL, 'http://', '');
		</cfscript>

		<cftry> 
			<cfscript>
			        port = port;
			        hostname = "#URL#";
			        factory = createObject('java', 'javax.net.ssl.HttpsURLConnection').getDefaultSSLSocketFactory();
			        socket = factory.createSocket(hostname, port);
			        socket.startHandshake();
			        serverCerts = socket.getSession().getPeerCertificates();
			        socket.close();
					serverCertsArray=ArrayNew(1);
			</cfscript>
			<cfcatch type="any">
				<cfreturn ('ERROR: ' & cfcatch.message)>
			</cfcatch>
		</cftry>
		
		<cfloop from="1" to="#ArrayLen(serverCerts)#" index="i">
			<cfset tempstruct=StructNew("Ordered")>
			<cfscript>
				StructInsert(tempstruct,"CheckPerformedDate", DateTimeFormat(now(), "yyyy.MM.dd 'at' HH:nn:ss z") );
				StructInsert(tempstruct,"CheckURL", hostname );	
				StructInsert(tempstruct,"NotBeforeValidDate", DateTimeFormat(serverCerts[i].getNotBefore(), "yyyy.MM.dd 'at' HH:nn:ss z") );
				StructInsert(tempstruct,"NotAfterInvalidDate", DateTimeFormat(serverCerts[i].getNotAfter(), "yyyy.MM.dd 'at' HH:nn:ss z") );
				StructInsert(tempstruct,"SerialNumber", NumberFormat(serverCerts[i].getSerialNumber(), '9999999999999999999999999999999999999999999999999999') );
				StructInsert(tempstruct,"SigAlgName", serverCerts[i].getSigAlgName() );				
				StructInsert(tempstruct,"SigAlgOID", serverCerts[i].getSigAlgOID() );
				StructInsert(tempstruct,"BasicConstraints", serverCerts[i].getBasicConstraints() );				
				StructInsert(tempstruct,"Version", serverCerts[i].getVersion() );
				StructInsert(tempstruct,"hasUnsupportedCriticalExtension", serverCerts[i].hasUnsupportedCriticalExtension() );
				StructInsert(tempstruct,"hashCode", serverCerts[i].hashCode() );
				StructInsert(tempstruct,"IssuerX500Principal", serverCerts[i].getIssuerX500Principal().toString() );
				StructInsert(tempstruct,"NonCriticalExtensionOIDs_isEmpty", serverCerts[i].getNonCriticalExtensionOIDs().isEmpty() );
				StructInsert(tempstruct,"NonCriticalExtensionOIDs_size", serverCerts[i].getNonCriticalExtensionOIDs().size() );
				//StructInsert(tempstruct,"NonCriticalExtensionOIDs_spliterator", serverCerts[i].getNonCriticalExtensionOIDs().spliterator()   );
				StructInsert(tempstruct,"SubjectDN_toString", serverCerts[i].getSubjectDN().toString() );
				StructInsert(tempstruct,"IssuerDN_toString", serverCerts[i].getIssuerDN().toString() );
				StructInsert(tempstruct,"CriticalExtensionOIDs_isEmpty", serverCerts[i].getCriticalExtensionOIDs().isEmpty() );
				StructInsert(tempstruct,"CriticalExtensionOIDs_size", serverCerts[i].getCriticalExtensionOIDs().size() );
				//StructInsert(tempstruct,"CriticalExtensionOIDs_spliterator", serverCerts[i].getCriticalExtensionOIDs().spliterator() );
				//StructInsert(tempstruct,"KeyUsageArray", serverCerts[i].getKeyUsage() );
				StructInsert(tempstruct,"KeyUsage_digitalSignature", serverCerts[i].getKeyUsage()[1] );
				StructInsert(tempstruct,"KeyUsage_nonRepudiation", serverCerts[i].getKeyUsage()[2] );
				StructInsert(tempstruct,"KeyUsage_keyEncipherment", serverCerts[i].getKeyUsage()[3] );
				StructInsert(tempstruct,"KeyUsage_dataEncipherment", serverCerts[i].getKeyUsage()[4] );
				StructInsert(tempstruct,"KeyUsage_keyAgreement", serverCerts[i].getKeyUsage()[5] );
				StructInsert(tempstruct,"KeyUsage_keyCertSign", serverCerts[i].getKeyUsage()[6] );
				StructInsert(tempstruct,"KeyUsage_cRLSign", serverCerts[i].getKeyUsage()[7] );
				StructInsert(tempstruct,"KeyUsage_encipherOnly", serverCerts[i].getKeyUsage()[8] );
				StructInsert(tempstruct,"KeyUsage_decipherOnly", serverCerts[i].getKeyUsage()[9] );
				StructInsert(tempstruct,"PublicKey_binary", serverCerts[i].getPublicKey().getEncoded()  );
				StructInsert(tempstruct,"EncryptEngine", serverCerts[i].a()   );
				StructInsert(tempstruct,"TBSCertificate", serverCerts[i].getTBSCertificate()  );

				serverCertsArray[i] = tempstruct;
			</cfscript>

		</cfloop>
		<cfreturn (serverCertsArray)>		
	</cffunction>
</cfcomponent>
