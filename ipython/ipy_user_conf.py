import ipy_defaults
import IPython.ipapi
ip = IPython.ipapi.get()

def main():
    ip.options.pylab_import_all = 0

    def import_quantities(self, arg):
        ip.ex('import quantities as pq')
    ip.expose_magic('pq', import_quantities)

    def import_constants(self, arg):
        ip.ex('import scipy.constants as const')
    ip.expose_magic('const', import_constants)

    def import_traits(self, arg):
        ip.ex('import enthought.traits.api as traits')
    ip.expose_magic('traits', import_traits)

    def import_chaco(self, arg):
        ip.ex('import enthought.chaco.api as chaco')
    ip.expose_magic('chaco', import_chaco)

    def import_ui(self, arg):
        ip.ex('import enthought.traits.ui.api as ui')
    ip.expose_magic('ui', import_ui)

    def import_imgio(self, arg):
        ip.ex('import scikits.image.io as imgio')
    ip.expose_magic('imgio', import_imgio)

    def import_ndimg(self, arg):
        ip.ex('import scipy.ndimage as ndimg')
    ip.expose_magic('ndimg', import_ndimg)

    import numpy as np
    np.set_printoptions(precision=3)

main()
