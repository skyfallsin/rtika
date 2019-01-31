module RbFiles
  class SampleFile < BaseFile
    def name
      "sample.pdf"
    end

    def pages
      [page_1, page_2]
    end

    private

    def page_1
      "\n A Simple PDF File \n This is a small demonstration .pdf file - \n\n just for use in the Virtual Mechanics tutorials. More text. And more \n text. And more text. And more text. And more text. \n\n And more text. And more text. And more text. And more text. And more \n text. And more text. Boring, zzzzz. And more text. And more text. And \n more text. And more text. And more text. And more text. And more text. \n And more text. And more text. \n\n And more text. And more text. And more text. And more text. And more \n text. And more text. And more text. Even more. Continued on page 2 ...\n\n\n"
    end

    def page_2
      "\n Simple PDF File 2 \n ...continued from page 1. Yet more text. And more text. And more text. \n And more text. And more text. And more text. And more text. And more \n text. Oh, how boring typing this stuff. But not as boring as watching \n paint dry. And more text. And more text. And more text. And more text. \n Boring.  More, a little more text. The end, and just as well. \n\n\n"
    end
  end
end
