$path = "c:\TEMP\Cert_11\1.crt"
# Import-Module PKI
# Import-Certificate -FilePath $path -CertStoreLocation 'Cert:\LocalMachine\My' -Verbose


function Import-CertificateX509 {
    param (
    [string]$Path
    )
    try {
    $CertificatePath = (Get-item $Path).fullname
    }
    catch {
    throw ("Can't get the full path for the supplied name: {0}" -f $Path)
    }
    
    $Certificate = new-object system.security.cryptography.x509certificates.x509certificate2
    $Certificate.Import($CertificatePath)
    
    #Trusted Root Certification Authorities
    $store = Get-Item cert:\LocalMachine\Root
    $store.Open([System.Security.Cryptography.X509Certificates.OpenFlags]"ReadWrite")
    $store.add($Certificate)
    $store.Close()
    }

    Import-CertificateX509 $path