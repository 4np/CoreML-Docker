FROM ubuntu

COPY requirements.txt /requirements.txt

# Install general dev tools
RUN apt-get update && apt-get install -y \ 
    wget \
    python2.7 \
    python-pip \
    python-dev \
    ipython \
    ipython-notebook 

# Install python requirements
RUN pip install --upgrade pip
RUN pip install -r requirements.txt

# Install Jupyter Plugins
RUN pip install ipywidgets
RUN jupyter nbextension enable --py widgetsnbextension

# Create workspace directory
RUN mkdir -p /workspace/models

# Make port 8888 available to the world outside this container
EXPOSE 8888

# Launch Jupyter notebook
CMD ["jupyter-notebook","--allow-root", "--ip=0.0.0.0", "--notebook-dir=/workspace"]
