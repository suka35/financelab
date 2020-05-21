import numpy as np
import scipy.stats as stat
import plotly.graph_objs as go
from plotly.offline import download_plotlyjs, init_notebook_mode, plot, iplot
init_notebook_mode(connected=False)

def theta(option_type, S, K, r, T, sigma):
    d1 = (np.log(S/K)+(r+0.5*(sigma**2))*T) / (sigma*np.sqrt(T))
    d2 = d1 - sigma*T**0.5
    
    return (-sigma*S*stat.norm.pdf(d1)) / (2*np.sqrt(T))- option_type * (r*K*np.exp(-r*T)*stat.norm.cdf(option_type*d2))

call = 1
put = -1

K = 100
r = 0.01
sigma = 0.25

n1 = 100
n2 = 50

start_t = 0.000001
end_t = 1
start_s = 0.000001
end_s = 200

T = np.linspace(start_t, end_t, n1)
S = np.linspace(start_s, end_s, n1)
T, S = np.meshgrid(T, S)

call_theta = theta(call, S, K, r, T, sigma)
put_theta = theta(put, S, K, r, T, sigma)

trace = go.Surface(x=T, y=S, z=call_theta, colorscale='Jet', opacity=0.8,
                   contours_x=dict(show=True, color="black", start=start_t, end=end_t, size=(end_t - start_t)/n2, project_x=True),
                   contours_y=dict(show=True, color="black", start=start_s, end=end_s, size=(end_s - start_s)/n2, project_y=True))

data = [trace]
layout = go.Layout(title='Call Theta Surface',
                   scene={'xaxis':{'title':'Maturity'}, 'yaxis':{'title':'Spot Price'},'zaxis':{'title':'Theta'}},
                   width=800, height=800, autosize=False,
                   margin=dict(pad=0)
                   )
fig = go.Figure(data=data, layout=layout)
plot(fig)
