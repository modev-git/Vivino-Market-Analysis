import plotly.graph_objects as go

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
            colorscale='Picnic',
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