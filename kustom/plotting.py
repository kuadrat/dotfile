"""
Useful propcycle elements for plotting.
Usage:

from matplotlib import rc
rc("axes", prop_cycle=<insert your cycler here>)

"""

from cycler import cycler
from itertools import islice


# +----------------+ #
# | Color palettes | # =========================================================
# +----------------+ #

# A colorblind friendly almost optimally distinct palette of colors
kolorful = ["#00599f", "#8f0033", "#d8c4f5", "#009757", "#cd690f", "#c653c1", \
            "#1990ff", "#222222"]

# Kevin's custom colors
k1 = ["#386cb0", "#7fc97f", "#fdc97f", "#e30278", "#751b6d", "#d8c4f5", \
      "#bf5b16", "#222222"]
k2 = ["#7b5db3", "#40b959", "#bb543e", "#c8ab42", "#0c214b", "#7ce1d1", "#ad2e6e", "#161300"]


# +--------------+ #
# | Marker lists | # ===========================================================
# +--------------+ #

# A list of 8 different markers
markers8 = ["o", "v", "s", "^", "p", "<", "*", ">"]
markers4 = 2 * ["o", "v", "s", "^"]


# +-----------------+ #
# | Linestyle lists | # ========================================================
# +-----------------+ #

# A list of 4 different linestyles
linestyles4 = 2 * ["-", "--", "-.", ":"]


# +--------------+ #
# | Prop cyclers | # ===========================================================
# +--------------+ #

# A cycler that guarantees differentiability of 8 lines
markerlinecolorcycler = cycler("marker", markers8) + \
                        cycler("color", k1) + \
                        cycler("linestyle", linestyles4)

# Same as markerlinecolorcycler but with solid lines for all
markercolorcycler     = cycler("marker", markers8) + \
                        cycler("color", k1)


# +-----------+ #
# | Utilities | # ==============================================================
# +-----------+ #

def make_cycler(color = k2, **kwargs) : #lines = None, markers = None) :
    """ 
    Create a cycler from different elements. The kwargs need to be 
    :class: cycler keyword arguments.
    """
    result = cycler("color", color)
    for arg in kwargs :
        result += cycler(arg, kwargs[arg])
    return result


def advance_cycler(ax, n=1) :
    """
    Advance the state of a cycler by n steps.

    Inputs:
    -------
    ax      : matplotlib.axes._suplots.AxesSubplot instance; The subplot in 
    which to advance the cycler.
    n       : int; The number of steps to advance the cycler by

    Outputs:
    --------
    None
    """
    if n < 1 or type(n) != int :
        raise ValueError(
"Number of steps should be a positive integer, got {}.".format(n))

    for i in range(n) :
        next(ax._get_lines.prop_cycler)


def rewind_cycler(ax) :
    """
    Rewind the cycler to the last position that was used, i.e. the next line 
    will have the same colour as the last one that was drawn.
    Note: this is done very crudely - if you know the length of your cycler it
    might be better to just use the 'advance_cycler' method with argument 
    'len(cycler)-1'.

    Inputs:
    -------
    ax      : matplotlib.axes._suplots.AxesSubplot instance; The subplot in 
    which to advance the cycler.

    Outputs:
    --------
    None
    """
    cyc = ax._get_lines.prop_cycler
    # In order to get the length, iterate until you get the same result again
    # First, safe a starting value
    start = next(islice(cyc, 0, None), None)
    current = None
    length = 0
    while current != start :
        current = next(islice(cyc, 0, None), None)
        length += 1

    # Now advance the cycle by the length - 2 (-2 because we advanced one in 
    # the while loop above)
    advance_cycler(ax, length - 2)


def set_cycler(color=k2, **kwargs) :
    """ 
    Shorthand for setting the cycler. Uses kustom.plotting.make_cycler to 
    create a cycler according to given kwargs and imports and updates 
    matplotlibrc.  
    """
    # Define the cycler
    my_cycler = make_cycler(color=color, **kwargs)
    # Set the cycler in the matplotlibrc
    from matplotlib import rc
    rc("axes", prop_cycle=my_cycler)
