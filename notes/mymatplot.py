import matplotlib.pyplot as plt

fig = plt.figure()

ax1 = fig.add_subplot(2,2,1)
ax2 = fig.add_subplot(2,2,2)

from numpy.random import randn

#randn selects random samples from a standard normal distribution
#so the values are standard deviations above and below mean
print randn(500)
#plt.plot(randn(50).cumsum(), 'k--')
#fig.show()
