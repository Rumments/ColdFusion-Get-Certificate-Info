

<br>
<br>


<cfoutput>

<cfinvoke component="getCertificateInfo" method="getAllCertificateData" returnvariable="serverCerts" URL="www.google.com" port="443">
<cfdump var="#serverCerts#">
	
<br>
<br>

<cfinvoke component="getCertificateInfoVerbose" method="getAllCertificateData" returnvariable="serverCerts" URL="www.google.com" port="443">
<cfdump var="#serverCerts#">

</cfoutput>

<br>
<br>



