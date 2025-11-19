# dremio-agentic-ai-workshop

### Technical Documentation:
- [Dremio docs](https://docs.dremio.com)
- [Dremio MCP Server repo](https://github.com/dremio/dremio-mcp)

### Useful Tutorials and Blog Posts:
- [Dremio University tutorial: Claude and Dremio](https://university.dremio.com/course/dremio-docker-mcp-server)
- [Dremio Blog: Using the Dremio MCP Server with any LLM Model](https://www.dremio.com/blog/using-the-dremio-mcp-server-with-any-llm-model/)
- [Dremio Blog: Hands-on Introduction to Dremio Cloud Next Gen (Self-Guided Workshop)](https://www.dremio.com/blog/hands-on-introduction-to-dremio-cloud-next-gen-self-guided-workshop/)

This repository is to accompany Dremio's Agentic AI Virtual Workshops. It contains SQL scripts that refine sample Dremio datasets to create a basic, three-layer data pipeline, which will be interogated using an AI Agent. 

This repo contains the following scripts:
    - `complete_project.sql` - will create and save the rest of the views and medallion folder structure needed for the workshop.
    - `wiki_nyc_trips_enriched.txt` - markdown text to be used as the Dremio Wiki for the gold-level dataset `nyc_trips_enriched`.
    - `ai_agent_prompts.md` - the AI agent prompts used throughout the workshop.

## Setup

This workshop is designed to use the [Dremio Cloud](https://www.dremio.com/get-started/?utm_source=ev_buffer&utm_medium=influencer&utm_campaign=next-gen-cloud&utm_term=11-19-2025&utm_content=willmartin) free trial.

### 1. Add the workshop Namespace
After logging into Dremio Cloud, you will see a dark-blue sidebar of icons on the left side of the UI. Click on the second icon from the top, that looks like a table, which will take you to the dataset explorer page.

On the dataset explorer, click on the plus sign next to "Namespaces" and add a new Namespace called `workshop`. This will be used in the provided SQL script, so take care to enter this name correctly.

### 2. Prepare sample tables

On the dataset explorer, click on the "Add Source" button to bring up the "Add Data Source" pop-up window. In this list, under "Object Storage" select the option "Sample Source" which has Gnarly, the Dremio mascot, as its icon.

<p align="left">
  <img src=./images/image-1.1.webp width="250">
</p>

- Click through to `Samples."samples.dremio.com"` and click on the file `NYC-taxi-trips.csv` to [format the data to a table](https://docs.dremio.com/current/sonar/data-sources/entity-promotion/).

<p align="left">
  <img src=./images/image-1.2.webp width="250">
</p>

- In the Table Settings window that pops up, tick the box to `Extract Column Names` and click Save.

<p align="center">
  <img src=./images/image-1.3.webp>
</p>

- Back in the sample data list, the icon for this file will now have changed from a grey file to a purple table.

<p align="left">
  <img src=./images/image-1.4.webp width="250">
</p>

Repeat this same process for the following two datasets:

- `NYC-weather.csv`
- `SF weather 2018-2019.csv`

### 3. Create the medallion data structure

Open the [complete_project.sql](https://github.com/wpmartin/dremio-agentic-ai-workshop/blob/main/complete_project.sql) file contained in this repo. Copy the entire script into the Dremio SQL Runner (the third icon down on the UI sidebar, underneath the dataset explorer) and click "Run".

### 4. Create the semantic layer

Navigate to the dataset details sidebar for the `workshop.gold.nyc_trips_enriched` dataset. At the top of this sidebar add the label `application`.

At the bottom of the sidebar is the "Wiki" section. Click on the green "Edit wiki" text to open up a markdown text window. Copy the text from [wiki_nyc_trips_enriched.txt](https://github.com/wpmartin/dremio-agentic-ai-workshop/blob/main/wiki_nyc_trips_enriched.txt) into this window. Do not worry about the table ascii characters not aligning, as Dremio will handle these. Click the "Save" button in the bottom right of this window. 

### 5. Use the AI Agent

That is all the data prep completed! 

Now navigate to the home page of the Dremio UI (the home icon on the left sidebar, above the dataset explorer) to find the AI Agent interface. 

Open [ai_agent_prompts.md](https://github.com/wpmartin/dremio-agentic-ai-workshop/blob/main/ai_agent_prompts.md) and use these prompts to explore the datasets.