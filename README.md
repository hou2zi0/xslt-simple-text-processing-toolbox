# xslt-simple-text-processing-toolbox
Collection of description of concepts, procedures, and simple XSLT files for text processing, e.g. simplify InDesign documents (.idml) to simplified xml, or Office formats (.fodt, .odt, .docx) to simplified XML. Subsequently the simplified XML may function as a foundation from where nested TEI-XML may be generated.

The following sections explain the [scripts](#scripts) that may be used to process the source files. The scripts sections are followed by a section that exemplifies several concepts, workflows, and approaches to text processing and transformation of XML based text files into TEI-XML.

## Scripts

### Flat Open Document (FODT)

![Schematic diagram FODT](concepts/en--fodt_schema.png)

#### Transformation to Base XML

* `fodt2base_XML_elements.xsl`
* `fodt2base_XML_elements_attributes.xsl`
* `fodt2base_XML_complex.xsl`

#### Transformation to Base HTML

* `fodt2base_HTML_elements_attributes.xsl`

### MS Word (DOCX)

Nothing here yet …

### InDesign Markup Languag (IDML)

#### Transformation to Base XML

* `idml2base_XML.xsl.xsl`

### Mark Down (MD)

Nothing here yet …

## Workflows & Concepts

![Schematic diagram text processing to edition](concepts/en--mini_edition_workflow.png)
