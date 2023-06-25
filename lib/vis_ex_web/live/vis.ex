defmodule VisExWeb.Vis do
  # In Phoenix v1.6+ apps, the line is typically: use MyAppWeb, :live_view
  use VisExWeb, :live_view

  def render(assigns) do
    ~L"""
    <%= if @loading do %>
      <div>Loading information…</div>
    <% else %>
      <h1><%= @diagram.name %></h1>
      <h5><%= @diagram.uuid %></h5>
      <h3><%= @diagram.description %></h3>
      <div id="diagram"
           style="width:800px; height:400px; border:1px solid lightgray"
           phx-hook="Diagram"
           data-diagram-data="<%= Poison.encode!(diagram_to_json(@diagram)) %>"></div>
      <p/>
    <% end %>
    """
  end

  def mount(_params, _session, socket) do
    {:ok, assign(socket, loading: true)}
  end

  def handle_info({:load_diagram, params}, socket) do
    diagram = get_diagram(params["id"])

    {:noreply,
     assign(socket,
       loading: false,
       diagram: diagram
     )}
  end

  def handle_params(params, _uri, socket) do
    send(self(), {:load_diagram, params})
    {:noreply, assign(socket, loading: true)}
  end

  def get_diagram(_id) do
    %{:name => "SimpleNode", :uuid => "001", :description => "A simple Node diagram"}
  end

  def diagram_to_json(_) do
    %{
      :nodes => [
        %{:id => 1, :label => "node1", :description => "desc node1"},
        %{:id => 2, :label => "node2"},
        %{:id => 3, :label => "node3"},
        %{:id => 4, :label => "node4"},
        %{:id => 5, :label => "node5"},
        %{:id => 6, :label => "node6"},
        %{:id => 7, :label => "node7"},
        %{:id => 8, :label => "node8"},
      ],
      :edges => [
        %{:id => 1, :from => 1, :to => 2, :arrows => "to,from", :physics => "false"},
        %{:id => 3, :from => 1, :to => 3, :arrows => "to", :physics => "false"},
        %{:id => 4, :from => 1, :to => 8, :arrows => "to", :physics => "false", :dashes => "true"},
        %{:id => 6, :from => 2, :to => 4, :arrows => "to", :physics => "false"},
        %{:id => 7, :from => 2, :to => 5, :arrows => "to, middle, from", :physics => "false"},
        %{:id => 10, :from => 7, :to => 6, :arrows => "to", :physics => "false"},
        %{:id => 11, :from => 5, :to => 6}

      ]
    }
  end
end
