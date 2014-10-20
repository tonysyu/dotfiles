ip = get_ipython()


def _main():
    import numpy as np
    try:
        from StringIO import StringIO
    except:
        from io import StringIO


    def import_quantities(self, arg):
        ip.ex('import quantities as pq')
    ip.define_magic('pq', import_quantities)

    def import_constants(self, arg):
        ip.ex('import scipy.constants as const')
    ip.define_magic('const', import_constants)

    def import_traits(self, arg):
        ip.ex('import enthought.traits.api as traits')
    ip.define_magic('traits', import_traits)

    def import_chaco(self, arg):
        ip.ex('import enthought.chaco.api as chaco')
    ip.define_magic('chaco', import_chaco)

    def import_ui(self, arg):
        ip.ex('import enthought.traits.ui.api as ui')
    ip.define_magic('ui', import_ui)

    def import_imgio(self, arg):
        ip.ex('import skimage.io as sio')
    ip.define_magic('sio', import_imgio)

    def import_ndimg(self, arg):
        ip.ex('import scipy.ndimage as ndimg')
    ip.define_magic('ndimg', import_ndimg)

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
    ip.define_magic('array_paste', array_paste)

    from yutils import print_ctree
    def ptree(self, arg):
        obj = globals()[arg]
        return print_ctree(obj)
    ip.define_magic('ptree', ptree)

_main()
