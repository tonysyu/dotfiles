from IPython.core.magic import register_line_cell_magic


ip = get_ipython()


def _main():
    import numpy as np
    try:
        from StringIO import StringIO
    except:
        from io import StringIO

    @register_line_cell_magic
    def array_paste(self, arg):
        array_text = ip.hooks.clipboard_get()
        try:
            array = np.genfromtxt(StringIO(array_text))
        except ValueError:
            print("Clipboard text does not look like an array:")
            print("~" * 60)
            print(array_text)
            print("~" * 60)
            raise
        return array

    from yutils import print_ctree
    @register_line_cell_magic
    def ptree(self, arg):
        obj = globals()[arg]
        return print_ctree(obj)

_main()
