<?xml version = "1.0" encoding = "UTF-8"?>
<!--
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#
# Copyright (C) 2009 - 2016 Open Microscopy Environment
#       Massachusetts Institute of Technology,
#       National Institutes of Health,
#       University of Dundee,
#       University of Wisconsin at Madison
#
#    This library is free software; you can redistribute it and/or
#    modify it under the terms of the GNU Lesser General Public
#    License as published by the Free Software Foundation; either
#    version 2.1 of the License, or (at your option) any later version.
#
#    This library is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
#    Lesser General Public License for more details.
#
#    You should have received a copy of the GNU Lesser General Public
#    License along with this library; if not, write to the Free Software
#    Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
#
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:OME="http://www.openmicroscopy.org/Schemas/OME/2015-01"
    xmlns:Bin="http://www.openmicroscopy.org/Schemas/BinaryFile/2015-01"
    xmlns:SPW="http://www.openmicroscopy.org/Schemas/SPW/2015-01"
    xmlns:SA="http://www.openmicroscopy.org/Schemas/SA/2015-01"
    xmlns:ROI="http://www.openmicroscopy.org/Schemas/ROI/2015-01"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    xmlns:xml="http://www.w3.org/XML/1998/namespace"
    exclude-result-prefixes="OME Bin SPW SA ROI"
    xmlns:exsl="http://exslt.org/common"
    extension-element-prefixes="exsl" version="1.0">

    <xsl:variable name="newOMENS">http://www.openmicroscopy.org/Schemas/OME/2016-DEV0</xsl:variable>
    <xsl:variable name="newSPWNS">http://www.openmicroscopy.org/Schemas/OME/2016-DEV0</xsl:variable>
    <xsl:variable name="newBINNS">http://www.openmicroscopy.org/Schemas/OME/2016-DEV0</xsl:variable>
    <xsl:variable name="newROINS">http://www.openmicroscopy.org/Schemas/OME/2016-DEV0</xsl:variable>
    <xsl:variable name="newSANS">http://www.openmicroscopy.org/Schemas/OME/2016-DEV0</xsl:variable>

    <xsl:output method="xml" indent="yes"/>
    <xsl:preserve-space elements="*"/>

    <!-- Actual schema changes -->

    <!-- strip Namespace from ROI -->
    <xsl:template match="ROI:ROI/@Namespace"/>

    <!-- strip Visible from Shape -->
    <xsl:template match="ROI:Shape/@Visible"/>

    <!-- Rewrite all namespaces -->

    <xsl:template match="OME:OME">
        <OME xmlns="http://www.openmicroscopy.org/Schemas/OME/2016-DEV0"
            xmlns:OME="http://www.openmicroscopy.org/Schemas/OME/2016-DEV0"
            xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
            xsi:schemaLocation="http://www.openmicroscopy.org/Schemas/OME/2016-DEV0
            http://www.openmicroscopy.org/Schemas/OME/2016-DEV0/ome.xsd">
            <xsl:apply-templates select="@UUID|@Creator|node()"/> <!-- copy UUID and Creator attributes and nodes -->
        </OME>
    </xsl:template>

    <!-- Move all BinaryFile, SA, SPW and ROI elements into the OME namespace -->

    <xsl:template match="OME:*">
        <xsl:element name="{local-name()}" namespace="{$newOMENS}">
            <xsl:apply-templates select="@*|node()"/>
        </xsl:element>
    </xsl:template>

    <xsl:template match="Bin:*">
        <xsl:element name="{local-name()}" namespace="{$newBINNS}">
            <xsl:apply-templates select="@*|node()"/>
        </xsl:element>
    </xsl:template>

    <xsl:template match="SA:*">
        <xsl:element name="{local-name()}" namespace="{$newSANS}">
            <xsl:apply-templates select="@*|node()"/>
        </xsl:element>
    </xsl:template>

    <xsl:template match="SPW:*">
        <xsl:element name="{local-name()}" namespace="{$newSPWNS}">
            <xsl:apply-templates select="@*|node()"/>
        </xsl:element>
    </xsl:template>

    <xsl:template match="ROI:*">
        <xsl:element name="{local-name()}" namespace="{$newROINS}">
            <xsl:apply-templates select="@*|node()"/>
        </xsl:element>
    </xsl:template>

    <!-- Default processing -->

    <xsl:template match="@*|node()">
        <xsl:copy>
            <xsl:apply-templates select="@*|node()"/>
        </xsl:copy>
    </xsl:template>

</xsl:stylesheet>
