import plotly.graph_objects as go

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

# Country leaderboard visualization
def plot_country_leaderboard(country_data: list):

        # 1. Build the DataFrame (Ascending order so Plotly stacks highest at the top)
    data = {
        'Country': ['Croatie', 'Suisse', 'Grèce', 'Roumanie', 'Argentine', 'Chili', 'Italie', 
                    'Espagne', 'Portugal', 'France', 'Afrique du Sud', 'Australie', 'Hongrie', 
                    'Moldavie', 'États-Unis', 'Allemagne', 'Israël'],
        'Average Rating': [4.3, 4.35, 4.4, 4.4, 4.42, 4.43, 4.43, 4.44, 4.44, 4.45, 4.46, 
                        4.46, 4.47, 4.48, 4.49, 4.5, 4.5]
    }
    df = pd.DataFrame(data)

    # 2. Instantiate the Base Geometry
    fig = px.bar(
        df,
        x='Average Rating',
        y='Country',
        orientation='h',
        text='Average Rating',
        color='Average Rating',
        color_continuous_scale='Blues'
    )

    # 3. Enforce the Layout Architecture
    fig.update_layout(
        xaxis=dict(range=[0, 5]),
        title='Global Leaderboard: Average Wine Rating',
        coloraxis_showscale=False
    )

    # 4. Position the Labels
    fig.update_traces(textposition='outside')

    # 5. Render
    fig.show()