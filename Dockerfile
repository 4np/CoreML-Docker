FROM ubuntu

COPY requirements.txt /requirements.txt

# Install general dev tools
RUN apt-get update && apt-get install -y \ 
    wget \
    python3 \
    python3-pip \
    python3-dev \
    ipython3

# Install python requirements
RUN pip3 install ipython[notebook]
RUN pip3 install --upgrade pip
RUN pip3 install -r requirements.txt

# Install Jupyter Plugins
RUN pip3 install ipywidgets
RUN jupyter nbextension enable --py widgetsnbextension

# Workaround for jupyter kernel crashes
RUN pip3 install 'jupyter-console==5.2.0'
RUN pip3 install 'prompt-toolkit>=1.0.15,<2.0.0'

# Create workspace directory
RUN mkdir -p /workspace/models

# Make port 8888 available to the world outside this container
EXPOSE 8888

# Launch Jupyter notebook
CMD ["jupyter-notebook","--allow-root", "--ip=0.0.0.0", "--notebook-dir=/workspace", "--NotebookApp.token=''", "--NotebookApp.password=''"]
