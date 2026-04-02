import plotly.graph_objects as go
import pandas as pd
import plotly.express as px 

# Highlight top 10 wines visualization
def plot_top_10_bar(top_10_data: list):
    # Unpack the data
    names = [row[0] for row in top_10_data]
    ratings = [row[1] for row in top_10_data]
    counts = [row[2] for row in top_10_data]

    # Plotly draws horizontal bars from bottom to top. 
    # We reverse the lists so the #1 wine appears at the very top.
    names.reverse()
    ratings.reverse()
    counts.reverse()

    fig = go.Figure(go.Bar(
        x=ratings,
        y=names,
        orientation='h',
        marker=dict(
            color=counts,
            colorscale= [
                [0, '#f2e6e6'],   # Lightest (Low Trust)
                [0.5, '#a63a50'], # Middle
                [1, '#590d22']    # Deep Burgundy (High Trust)
        ],
            showscale=True,
            colorbar=dict(title='Total Reviews')
        ),
        text=[f'{r}⭐' for r in ratings],
        textposition='inside',
        insidetextanchor='middle'
    ))

    fig.update_layout(
        title="Top 10 Wines to Highlight (The 'Hidden Gems')",
        xaxis_title="Average Rating",
        xaxis=dict(range=[4.5, 4.8]), # Zoom in on the relevant mathematical variance
        yaxis_title="",
        template="plotly_white",
        height=600
    )

    return fig

# Country leaderboard visualization
def create_horizontal_leaderboard(data: dict, x_col: str, y_col: str, title_text: str):

    # 1. Convert the data into a DataFrame
    df = pd.DataFrame(data)

    # 2. Instantiate the Base Geometry
    fig = px.bar(
        df,
        x=x_col,
        y=y_col,
        orientation='h',
        text='Average Rating',
        color='Average Rating',
        color_continuous_scale='Blues'
    )

    # 3. Enforce the Layout Architecture
    fig.update_layout(
        xaxis=dict(range=[0, 5]),
        title=title_text,
        coloraxis_showscale=False
    )

    # 4. Position the Labels
    fig.update_traces(textposition='outside')

    # 5. Render
    return fig