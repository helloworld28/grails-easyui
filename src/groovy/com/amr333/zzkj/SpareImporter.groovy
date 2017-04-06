package com.amr333.zzkj

import org.codehaus.groovy.grails.commons.GrailsApplication
import org.grails.plugins.excelimport.AbstractExcelImporter

/**
 * 易损件原始资料导入
 * Created by Administrator on 2017-01-18.
 */
class SpareImporter extends AbstractExcelImporter{
    def grailsApplication
    static Map CONFIG_BOOK_CELL_MAP = [
            sheet:'工作表 1 - 环模导入表',
            cellMap: [ 'D3':'title',
                       'D4':'author',
                       'D6':'numSold',
            ]
    ]

    static Map CONFIG_BOOK_COLUMN_MAP = [
            sheet:'工作表 1 - 环模导入表',
            startRow: 3,
            columnMap:  [
                    'A':'number',
                    'B':'category',
                    'C':'zljxh',
                    'D':'sizes',
                    'E':'radius',
                    'F':'percent',
                    'G':'material',
                    'H':'price'
            ]
    ]
    public SpareImporter(fileName) {
        super(fileName)
    }

    //can also configure injection in resources.groovy
    def getExcelImportService() {
        grailsApplication.mainContext.getBean('excelImportService')
    }

    public void setGrailsApplication(GrailsApplication grailsApplication){
        this.grailsApplication = grailsApplication
    }


    List<Map> getSpareList() {
        List spareList = excelImportService.columns(workbook, CONFIG_BOOK_COLUMN_MAP)
    }


    Map getOneMoreBookParams() {
        Map bookParams = excelImportService.cells(workbook, CONFIG_BOOK_CELL_MAP )
    }

}
