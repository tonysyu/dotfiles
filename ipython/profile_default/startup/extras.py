ip = get_ipython()

def main():
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

main()

