package de.andreasschmitt.export.exporter

import de.andreasschmitt.export.builder.ExcelBuilder
import jxl.format.Colour

/**
 * @author Andreas Schmitt
 *
 */
class ExcelWithSheetsExporter extends AbstractExporter {


    protected void exportData(OutputStream outputStream, List data, List fields) throws ExportingException {
        try {
            def builder = new ExcelBuilder()

            def otherSheetData = getOtherParameters()

            // Enable/Disable header output
            boolean isHeaderEnabled = true


            boolean useZebraStyle = false

            builder {
                workbook(outputStream: outputStream) {
                    sheet(name: getParameters().get("title") ?: "Export", widths: getParameters().get("column.widths"), numberOfFields: data.size(), widthAutoSize: getParameters().get("column.width.autoSize")) {

                        format(name: "title") {
                            font(name: "arial", bold: true, size: 14)
                        }

                        format(name: "header") {
                            if (useZebraStyle) {
                                font(name: "arial", bold: true, backColor: Colour.GRAY_80, foreColor: Colour.WHITE, useBorder: true)
                            } else {
                                // Use default header format
                                font(name: "arial", bold: true)
                            }
                        }
                        format(name: "odd") {
                            font(backColor: Colour.GRAY_25, useBorder: true)
                        }
                        format(name: "even") {
                            font(backColor: Colour.WHITE, useBorder: true)
                        }

                        int rowIndex = 0

                        // Option for titles on top of data table
                        def titles = getParameters().get("titles")
                        titles.each {
                            cell(row: rowIndex, column: 0, value: it, format: "title")
                            rowIndex++
                        }

                        //Create header
                        if (isHeaderEnabled) {
                            fields.eachWithIndex { field, index ->
                                String value = getLabel(field)
                                cell(row: rowIndex, column: index, value: value, format: "header")
                            }

                            rowIndex++
                        }

                        //Rows
                        data.eachWithIndex { object, k ->
                            String format = useZebraStyle ? ((k % 2) == 0 ? "even" : "odd") : ""
                            fields.eachWithIndex { field, i ->
                                Object value = getValue(object, field)
                                cell(row: k + rowIndex, column: i, value: value, format: format)
                            }
                        }
                    }

                    if (otherSheetData != null) {
                        for (int i = 0; i < otherSheetData.length; i++) {
                            def sheetData = otherSheetData[i].datas
                            def sheetFields = otherSheetData[i].fields
                            sheet(name: otherSheetData[i].sheetName ?: "Export", widths: otherSheetData[i].get("column.widths"), numberOfFields: otherSheetData[i].datas.size(), widthAutoSize: otherSheetData[i].get("column.width.autoSize")) {

                                format(name: "title") {
                                    font(name: "arial", bold: true, size: 14)
                                }

                                format(name: "header") {
                                    if (useZebraStyle) {
                                        font(name: "arial", bold: true, backColor: Colour.GRAY_80, foreColor: Colour.WHITE, useBorder: true)
                                    } else {
                                        // Use default header format
                                        font(name: "arial", bold: true)
                                    }
                                }
                                format(name: "odd") {
                                    font(backColor: Colour.GRAY_25, useBorder: true)
                                }
                                format(name: "even") {
                                    font(backColor: Colour.WHITE, useBorder: true)
                                }

                                int rowIndex = 0

                                // Option for titles on top of data table
                                def titles = otherSheetData[i].titles
                                titles.each {
                                    cell(row: rowIndex, column: 0, value: it, format: "title")
                                    rowIndex++
                                }

                                //Create header
                                if (isHeaderEnabled) {
                                    sheetFields.eachWithIndex { field, index ->

                                        String title = field
                                        if(otherSheetData[i].labels.containsKey(field)){
                                            title =  otherSheetData[i].labels[field]
                                        }
                                        cell(row: rowIndex, column: index, value: title, format: "header")
                                    }

                                    rowIndex++
                                }

                                //Rows
                                sheetData.eachWithIndex { object, k ->
                                    String format = useZebraStyle ? ((k % 2) == 0 ? "even" : "odd") : ""
                                    sheetFields.eachWithIndex { field, n ->
                                        Object value = getValue(object, field)
                                        cell(row: k + rowIndex, column: n, value: value, format: format)
                                    }
                                }
                            }
                        }
                    }
                }


            }

            builder.write()
        }
        catch (Exception e) {
            throw new ExportingException("Error during export", e)
        }
    }

}