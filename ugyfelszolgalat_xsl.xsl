<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="2.0"
    xmlns:mf="ugyfelszolgalat">
    
    <xsl:template match="/">
        <html>
            <body>
                <h1 align="center" >Ugyfelszolgalat</h1>
                <h3 align="center">Heti Osszegzes</h3>
                <table border="0" bordercolor="#ffffff" align="center">
                    <xsl:for-each select="ugyfelszolgalat/csopvez">
                        <tr>
                            <td>
                                Csoportvezeto
                            </td>
                            <td>
                                <xsl:value-of select="@nev"/>
                            </td>
                        </tr>
                    </xsl:for-each>
                    <tr>
                        <td>
                            Ugyek szama
                        </td>
                        <td>
                            <xsl:value-of select="count(ugyfelszolgalat/ugy)"/>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            Operatorok szama
                        </td>
                        <td>
                            <xsl:value-of select="count(ugyfelszolgalat/operator)"/>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            Reklamalt ugyek szama
                        </td>
                        <td>
                            <xsl:value-of select="count(ugyfelszolgalat/reklamacio)"/>
                        </td>
                    </tr>
                </table>
                
                    
                <h2 align="center">Operatorok</h2>
                <ul  align="center">
                    <xsl:for-each select="//operator">
                        
                        <span>
                                <xsl:value-of select="mf:operator(@felh, @nev, @szgep)"/> <br/>
                           </span>
                        
                    </xsl:for-each>
                </ul>
                
                <h2 align="center">Ugyfelek ugyei</h2>
                <xsl:for-each select="ugyfelszolgalat/ugyfel">
                    <h4 align="center"><xsl:value-of select="@nev"/></h4>
                    <xsl:variable name="ugyfelszam" select="@ugyfelszam"/>
                    <ul align="center">
                                <xsl:for-each select="//ugy">
                                    <xsl:if test="mf:ugyfelugy($ugyfelszam, @ugyfel) = 1">
                                        
                                            <p>Ugyszam: <xsl:value-of select="@ugyszam"/></p>
                                        
                                    </xsl:if>
                                </xsl:for-each>
                            </ul>
                    </xsl:for-each>
                
                
                
                <h2 align="center">Ugyek listaja</h2>
                <table border="" bordercolor="#ffffff" align="center">
                    <tr>
                        <th>
                            Ugyszam
                        </th>
                        <th>
                            Ugyfelszam
                        </th>
                        <th>
                            Tipus
                        </th>
                        <th>
                            Megjegyzes
                        </th>
                    </tr>
                <xsl:for-each select="//ugy">
                    <xsl:apply-templates select="."/>
                </xsl:for-each>
                </table>
                
            </body>
        </html>
        
    </xsl:template>
    
    <xsl:template match="ugy">
            <xsl:for-each select=".">
                <tr>
                    <td>
                        <xsl:value-of select="attribute::ugyszam"/>
                    </td>
                    <td>
                        <xsl:value-of select="@ugyfel"/>
                    </td>
                    <td>
                        <xsl:value-of select="@tipus"/>
                    </td>
                    <td>
                        <xsl:value-of select="@megjegy"/>
                    </td>
                </tr>
            </xsl:for-each>
    </xsl:template>
    

    <xsl:function name="mf:operator">
        <xsl:param name="felh" as="xs:string"/>
        <xsl:param name="nev" as="xs:string"/>
        <xsl:param name="szgep" as="xs:string"/>
        <xsl:sequence select="concat('Felhasznalonev:', $felh,'|', 'Nev:', $nev , '|','Szamitogep:', $szgep)"/>
    </xsl:function>
    
    <xsl:function name="mf:ugyfelugy">
        <xsl:param name="ugyfelszam1" as="xs:string"/>
        <xsl:param name="ugyfel1" as="xs:string"/>
        <xsl:if test="$ugyfelszam1 = $ugyfel1">
            <xsl:sequence select="1"/>
        </xsl:if>
    </xsl:function>
</xsl:stylesheet>