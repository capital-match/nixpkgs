{ stdenv, fetchurl, pkgconfig, postgresql, curl, openssl, zlib, pcre, libevent, libiconv }:


let

  version = "3.4.8";
  branch = "3.4";

  src = fetchurl {
    url = "https://netix.dl.sourceforge.net/project/zabbix/ZABBIX%20Latest%20Stable/${version}/zabbix-${version}.tar.gz";
    sha256 = "cec14993d1ec2c9d8c51f6608c9408620f27174db92edc2347bafa7b841ccc07";
  };

in

{
  agent = stdenv.mkDerivation {
    name = "zabbix-agent-${version}";

    inherit src;

     configureFlags = [
      "--enable-agent"
      "--with-libpcre=${pcre.dev}"
      "--with-iconv=${libiconv}"
    ];
    buildInputs = [ pcre libiconv ];

    meta = with stdenv.lib; {
      inherit branch;
      description = "An enterprise-class open source distributed monitoring solution (client-side agent)";
      homepage = http://www.zabbix.com/;
      license = licenses.gpl2;
      maintainers = [ maintainers.eelco ];
      platforms = platforms.linux;
    };
  };

}

