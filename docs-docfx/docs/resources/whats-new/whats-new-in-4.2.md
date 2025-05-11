# What's New in 4.2

## Overview

This page shows a curated selection of features we've released in XMPro version 4.2. For more details on what's in the latest version, please read the [Release Notes](../../release-notes/archived/v4.2.0.md).

## Application Designer

### Recommendation and Alert Scoring

When setting up a Recommendation, authors are now able to fine-tune the Alert Recommendation priority by changing its score. By contrast, Alert Ranking only has options for High, Medium, and Low.

Alert Scores are calculated based on these factors:

* [**Recommendation**](../../how-tos/recommendations/manage-recommendations.md#create-a-recommendation) [ ](../../how-tos/recommendations/manage-recommendations.md#create-a-recommendation)-  The importance of the recommendation itself
* [**Recommendation Category**](../../how-tos/manage-categories.md#adding-a-new-category)  - The importance of the recommendation's category
* [**Recommendation Rule**](../../how-tos/recommendations/create-rules.md#create-rules) -  The importance of the specific rule
* [**Recommendation Optional**](../../how-tos/recommendations/create-rules.md#create-rules)- Additional Rule Factor value retrieved from the Data Stream.&#x20;

As a recommendation creator, assigning a score to an alert lets you control its importance level more precisely. This Score helps the alert recipient to understand its relative importance.

### Viewing the Alerts

You can view the order of alerts in the Recommendation Alerts list.

> [!NOTE]
> Image: Fig 1. Recommendation Alerts list (Image not available)

You can also view the Scores using the Score Factor Matrix. Follow the steps mentioned [here](../../concepts/recommendation/recommendation-scoring.md#viewing-the-recommendation-scoring).

> [!NOTE]
> Image: Fig 2. Score Factor Matrix (Image not available)

### Auto-Assigning of an Escalated Recommendation Alert

This enhancement automatically assigns an escalated recommendation alert to the previous owner of the original alert. 

To use this, simply check "enable execution order" and "auto-escalate" with the specified rules. 

> [!NOTE]
> Image: Fig 3. Auto-Assigning of an Escalated Recommendation Alert (Image not available)

You can view this as a timeline entry that creates an audit trail.

### Query Optimization for AD

Experience faster performance and quicker AD queries through optimized Entity Framework settings for database queries.

> [!NOTE]
> Image: Fig 4. Query Optimization for AD (Image not available)

## Subscription Manager

### New Permission - Hide Users Outside of Business Roles

This new permission prevents users' information from being exposed to users who are not in the same business role group or any of the parent business role groups, enhancing privacy and security.

> [!NOTE]
> Image: Fig 5. New Permission - Hide Users Outside of Business Roles (Image not available)

## Data Stream Designer

### Agent Category Visual Indicator

Introduced color palettes as visual cues for agent categories. As a user, you can now quickly distinguish between listeners, context providers, transformations, etc.

> [!NOTE]
> Image: Fig 6. Agent Category Visual Indicator (Image not available)
