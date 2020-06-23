<cfcomponent>
	<cffunction name="getAllCertificateData" output="false" >
		<cfargument name="URL" required="yes" type="string" >
		<cfargument name="port" required="yes" type="numeric" >  
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
		
		<cfloop from="1" to="#ArrayLen(serverCerts)#" index="i">
			<cfset tempstruct=StructNew("Ordered")>
			<cfscript>	
				StructInsert(tempstruct,"CheckPerformedDate", DateTimeFormat(now(), "yyyy.MM.dd 'at' HH:nn:ss z") );
				StructInsert(tempstruct,"CheckURL", hostname );
				tempval = 0;
				if (dateDiff("d", serverCerts[i].getNotBefore(), now()) gt 0) tempval = dateDiff("d", serverCerts[i].getNotBefore(), now());
				StructInsert(tempstruct,"CheckDaysLeftValid", tempval );
				tempval = 0;
				if (dateDiff("d", serverCerts[i].getNotAfter(), now()) gt 0) tempval = dateDiff("d", serverCerts[i].getNotAfter(), now());
				StructInsert(tempstruct,"CheckDaysUntilValid", tempval );
				StructInsert(tempstruct,"NotBeforeValidDate", DateTimeFormat(serverCerts[i].getNotBefore(), "yyyy.MM.dd 'at' HH:nn:ss z") );
				StructInsert(tempstruct,"NotAfterInvalidDate", DateTimeFormat(serverCerts[i].getNotAfter(), "yyyy.MM.dd 'at' HH:nn:ss z") );
				StructInsert(tempstruct,"SerialNumber", NumberFormat(serverCerts[i].getSerialNumber(), '9999999999999999999999999999999999999999999999999999') );
				StructInsert(tempstruct,"IssuerX500Principal", serverCerts[i].getIssuerX500Principal().toString() );
				StructInsert(tempstruct,"SubjectDN_toString", serverCerts[i].getSubjectDN().toString() );
				StructInsert(tempstruct,"IssuerDN_toString", serverCerts[i].getIssuerDN().toString() );
				serverCertsArray[i] = tempstruct;
			</cfscript>

		</cfloop>
		<cfreturn (serverCertsArray)>		
	</cffunction>
</cfcomponent>
