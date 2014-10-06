import matplotlib.pyplot as plt
import numpy as np

#plt.plot([1,3,3,4])
#plt.show()

#x = np.arange(0.0, 6.0, .01)
#print x
#plt.plot(x, [xi ** 2 for xi in x])
#plt.show()

x = np.arange(6)
#plt.plot(x, x * 1.5, '--')
#plt.plot(x, x * 3.0, '-.')
#plt.plot(x, x / 3.0, ':')
plt.plot(x, x * 1.5, 'o')
plt.plot(x, x * 3.0, 'v')
plt.plot(x, x / 3.0, 's')
plt.grid(True)

plt.axis([0,6,0,20])
plt.title('My First Matplotlib.Pyplot Plot')
plt.xlabel('This is the x axis')
plt.ylabel('This is the y axis')

plt.legend(loc='upper left')
plt.show()
plt.savefig('myplotfirst.png')
