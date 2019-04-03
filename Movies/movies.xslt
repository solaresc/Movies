<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl">
  <xsl:output method="html" indent="yes"/>
  <xsl:template match="/">
    <html>
      <head>
        <title>Movies</title>
      </head>
      <body>
        <h1>Movies Before 2005</h1>
        <table border="1" cellpadding="3" cellspacing="0" bgcolor="red" style="color:white">
          <tr bgcolor="black" style="color:white; font-family:calibri;">
            <th>ID</th>
            <th>Title</th>
            <th>Director</th>
            <th>Year</th>
            <th>Genre</th>
            <th>IMDB</th>
          </tr>
          <xsl:apply-templates select ="movies/movie[year &lt;2005]">
            <xsl:sort select="title"/>
          </xsl:apply-templates>
          <tr align="center" style="font-family:calibri;">
            <td colspan="6">Number of Movies: <xsl:value-of select="count(movies/movie[year &lt;2005])"/></td>
          </tr>
        </table>

        <ul>
          Directors:
          <xsl:for-each select="movies/movie[year &lt;2005]">
            <xsl:sort select="director"/>
            <li><xsl:value-of select="director"/></li>
          </xsl:for-each>
        </ul>

        <h1>Movies In/After 2005</h1>
        <table border="1" cellpadding="3" cellspacing="0" bgcolor="red" style="color:white">
          <tr bgcolor="black" style="color:white; font-family:calibri;">
            <th>ID</th>
            <th>Title</th>
            <th>Director</th>
            <th>Year</th>
            <th>Genre</th>
            <th>IMDB</th>
          </tr>
          <xsl:apply-templates select="movies/movie[year &gt;=2005]">
            <xsl:sort select="title"/>
          </xsl:apply-templates>
          <tr align="center" style="font-family:calibri;">
            <td colspan="6">Number of Movies: <xsl:value-of select="count(movies/movie[year &gt;=2005])"/></td>
          </tr>
        </table>

        <ul>
          Directors:
          <xsl:for-each select="movies/movie[year &gt;=2005]">
            <xsl:sort select="director"/>
           <li><xsl:value-of select="director" /></li>
          </xsl:for-each>
        </ul>

      </body>
    </html>
  </xsl:template>

  <xsl:template match="movies/movie">
    <tr align="center" style="font-family:calibri;">
      <td>
        <xsl:value-of select="@id"/>
      </td>
      <td>
        <xsl:choose>
         <xsl:when test="not(@type='lame')">
          <xsl:element name="a">
           <xsl:attribute name="href">
            <xsl:value-of select="imdb"/>
           </xsl:attribute>
           <xsl:value-of select="title"/>
          </xsl:element>
         </xsl:when>
         <xsl:otherwise>
          <xsl:value-of select="title"/>
         </xsl:otherwise>
        </xsl:choose>
      </td>
      <td>
        <xsl:value-of select="director"/>
      </td>
      <td>
        <xsl:value-of select="year"/>
      </td>
      <td>
        <xsl:apply-templates select="genre"/>
      </td>
      <td>
        <xsl:value-of select="imdb"/>
      </td>
    </tr>
  </xsl:template>

  <xsl:template match="genre">
      <xsl:value-of select="."/>
    <xsl:if test="position() != last()">
      <xsl:text>, </xsl:text>
    </xsl:if>
  </xsl:template>

</xsl:stylesheet>