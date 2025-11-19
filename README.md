# dremio-agentic-ai-workshop

- [Dremio docs](https://docs.dremio.com)
- [Dremio MCP Server repo](https://github.com/dremio/dremio-mcp)
- [Dremio University tutorial: Claude and Dremio](https://university.dremio.com/course/dremio-docker-mcp-server)
- [Dremio Blog: Using the Dremio MCP Server with any LLM Model](https://www.dremio.com/blog/using-the-dremio-mcp-server-with-any-llm-model/)
- [Dremio Blog: Hands-on Introduction to Dremio Cloud Next Gen (Self-Guided Workshop)](https://www.dremio.com/blog/hands-on-introduction-to-dremio-cloud-next-gen-self-guided-workshop/)

This repository is to accompany Dremio's Agentic AI Virtual Workshops. It contains SQL scripts that refine sample Dremio datasets to create a basic, three-layer data pipeline, which will be interogated using an AI Agent. 

- You will be creating and saving virtual datasets (Views) in Dremio.
- This workshop is designed to use the [Dremio Cloud](https://www.dremio.com/get-started/?utm_source=ev_buffer&utm_medium=influencer&utm_campaign=next-gen-cloud&utm_term=11-19-2025&utm_content=willmartin) free trial.
- This repo contains the following scripts:
    - `complete_project.sql` - will create and save the rest of the views and medallion folder structure needed for the workshop.
    - `wiki_trips_enriched.txt` - markdown documentation to be used as the Dremio Wiki for the gold-level dataset `trips_enriched`.
    - `ai_agent_prompts.md` - the llm prompts used throughout the workshop.
