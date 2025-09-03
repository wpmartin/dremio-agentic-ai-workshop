# dremio-agentic-ai-workshop

- [Dremio docs](https://docs.dremio.com)
- [Dremio MCP server repository](https://github.com/dremio/dremio-mcp)
- [Claude and Dremio: a Dremio University tutorial](https://university.dremio.com/course/dremio-docker-mcp-server)
- [Using the Dremio MCP Server with any LLM Model](https://www.dremio.com/blog/using-the-dremio-mcp-server-with-any-llm-model/)

This repository is to accompany Dremio's Agentic AI Virtual Workshops. It contains SQL scripts that refine sample Dremio datasets to create a basic, three-layer data pipeline. 

- You will be creating and saving virtual datasets (Views) in Dremio.
- You will need to create an Enterprise Catalog called `workshop` and add a folder called `bronze` into which a view will be manually created.
- This repo contains the following scripts:
    - `complete_project.sql` - will create and save the rest of the views and medallion folder structure needed for the workshop.
    - `wiki_trips_enriched.txt` - markdown documentation to be used as the Dremio Wiki for the gold-level dataset `trips_enriched`. Saved as a txt file to make it easier for you to copy.
    - `llm_prompts.md` - the llm prompts used throughout the workshop.
