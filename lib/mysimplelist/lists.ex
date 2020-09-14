defmodule Mysimplelist.Lists do
  @moduledoc """
  Interact with Lists, which contain ListItems.
  """

  import Ecto.Query, warn: false
  alias Mysimplelist.{Logger, Repo}

  alias Mysimplelist.Lists.List

  @doc """
  Returns the list of lists.

  ## Examples

      iex> list_lists()
      [%List{}, ...]

  """
  def list_lists do
    List
    |> Repo.all()
    |> Repo.preload(:user)
  end

  @doc """
  Gets a single list.

  Raises `Ecto.NoResultsError` if the List does not exist.

  ## Examples

      iex> get_list!(123)
      %List{}

      iex> get_list!(456)
      ** (Ecto.NoResultsError)

  """
  def get_list!(id) do
    Repo.get!(List, id)
    |> Repo.preload(:user)
  end

  @doc """
  Creates a list.

  ## Examples

      iex> create_list(%User{}, %{field: value})
      {:ok, %List{}}

      iex> create_list(%User{}, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_list(user, attrs \\ %{}) do
    %List{}
    |> List.changeset(attrs)
    |> Ecto.Changeset.put_assoc(:user, user, required: true)
    |> Logger.log(:List_Create)
    |> Repo.insert()
  end

  @doc """
  Updates a list.

  ## Examples

      iex> update_list(list, %{field: new_value})
      {:ok, %List{}}

      iex> update_list(list, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_list(%List{} = list, attrs) do
    list
    |> List.changeset(attrs)
    |> Logger.log(:List_Update)
    |> Repo.update()
  end

  @doc """
  Deletes a list.

  ## Examples

      iex> delete_list(list)
      {:ok, %List{}}

      iex> delete_list(list)
      {:error, %Ecto.Changeset{}}

  """
  def delete_list(%List{} = list) do
    list
    |> Logger.log(:List_Delete)
    |> Repo.delete()
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking list changes.

  ## Examples

      iex> change_list(list)
      %Ecto.Changeset{data: %List{}}

  """
  def change_list(%List{} = list, attrs \\ %{}) do
    List.changeset(list, attrs)
  end

  alias Mysimplelist.Lists.ListItem

  @doc """
  Returns the list of list_items.

  ## Examples

      iex> list_list_items()
      [%ListItem{}, ...]

  """
  def list_list_items do
    ListItem
    |> Repo.all()
    |> Repo.preload(:list)
  end

  @doc """
  Gets a single list_item.

  Raises `Ecto.NoResultsError` if the List item does not exist.

  ## Examples

      iex> get_list_item!(123)
      %ListItem{}

      iex> get_list_item!(456)
      ** (Ecto.NoResultsError)

  """
  def get_list_item!(id) do
    ListItem
    |> Repo.get!(id)
    |> Repo.preload(:list)
  end

  @doc """
  Creates a list_item.

  ## Examples

      iex> create_list_item(%{field: value})
      {:ok, %ListItem{}}

      iex> create_list_item(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_list_item(attrs \\ %{}) do
    %ListItem{}
    |> ListItem.changeset(attrs)
    |> Logger.log(:ListItem_Create)
    |> Repo.insert()
  end

  @doc """
  Updates a list_item.

  ## Examples

      iex> update_list_item(list_item, %{field: new_value})
      {:ok, %ListItem{}}

      iex> update_list_item(list_item, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_list_item(%ListItem{} = list_item, attrs) do
    list_item
    |> ListItem.changeset(attrs)
    |> Logger.log(:ListItem_Update)
    |> Repo.update()
  end

  @doc """
  Deletes a list_item.

  ## Examples

      iex> delete_list_item(list_item)
      {:ok, %ListItem{}}

      iex> delete_list_item(list_item)
      {:error, %Ecto.Changeset{}}

  """
  def delete_list_item(%ListItem{} = list_item) do
    list_item
    |> Logger.log(:ListItem_Delete)
    |> Repo.delete()
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking list_item changes.

  ## Examples

      iex> change_list_item(list_item)
      %Ecto.Changeset{data: %ListItem{}}

  """
  def change_list_item(%ListItem{} = list_item, attrs \\ %{}) do
    ListItem.changeset(list_item, attrs)
  end
end
