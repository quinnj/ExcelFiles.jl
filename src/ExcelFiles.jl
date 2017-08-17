module ExcelFiles


using ExcelReaders, TableTraits, IterableTables, DataValues, DataFrames
import FileIO

struct ExcelFile
    filename::String
    range::String
    keywords
end

function load(f::FileIO.File{FileIO.format"Excel"}, range; keywords...)
    return ExcelFile(f.filename, range, keywords)
end

TableTraits.isiterable(x::ExcelFile) = true
TableTraits.isiterabletable(x::ExcelFile) = true

function TableTraits.getiterator(file::ExcelFile)
    df = contains(file.range, "!") ? readxl(DataFrame, file.filename, file.range; file.keywords...) : readxlsheet(DataFrame, file.filename, file.range)

    it = getiterator(df)

    return it
end

end # module
