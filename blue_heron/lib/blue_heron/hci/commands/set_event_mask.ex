defmodule BlueHeron.HCI.Commands.SetEventMask do
  @moduledoc """
  Helper module for creating an events bit mask with atom keys
  representing events to include/exclude

  Bluetooth Spec v5.2, Vol 4, Part E, section 7.3.1
  """

  import Bitwise

  @events_map [
    {1 <<< 0, :inquiry_complete},
    {1 <<< 1, :inquiry_result},
    {1 <<< 2, :connection_complete},
    {1 <<< 3, :connection_request},
    {1 <<< 4, :disconnection_complete},
    {1 <<< 5, :authentication_complete},
    {1 <<< 6, :remote_name_request_complete},
    {1 <<< 7, :encryption_change},
    {1 <<< 8, :change_connection_link_key_complete},
    {1 <<< 9, :master_link_key_complete},
    {1 <<< 10, :read_remote_supported_features_complete},
    {1 <<< 11, :read_remote_version_information_complete},
    {1 <<< 12, :qos_setup_complete},
    {1 <<< 15, :hardware_error},
    {1 <<< 16, :flush_occurred},
    {1 <<< 17, :role_change},
    {1 <<< 19, :mode_change},
    {1 <<< 20, :return_link_keys},
    {1 <<< 21, :pin_code_request},
    {1 <<< 22, :link_key_request},
    {1 <<< 23, :link_key_notification},
    {1 <<< 24, :loopback_command},
    {1 <<< 25, :data_buffer_overflow},
    {1 <<< 26, :max_slots_change},
    {1 <<< 27, :read_clock_offset_complete},
    {1 <<< 28, :connection_packet_type_changed},
    {1 <<< 29, :qos_violation},
    {1 <<< 30, :page_scan_mode_change},
    {1 <<< 31, :page_scan_repetition_mode_change},
    {1 <<< 32, :flow_specification_complete},
    {1 <<< 33, :inquiry_resultwith_rssi},
    {1 <<< 34, :read_remote_extended_features_complete},
    {1 <<< 43, :synchronous_connection_complete},
    {1 <<< 44, :synchronous_connection_changed},
    {1 <<< 45, :sniff_subrating},
    {1 <<< 46, :extended_inquiry_result},
    {1 <<< 47, :encryption_key_refresh_complete},
    {1 <<< 48, :io_capability_request},
    {1 <<< 49, :io_capability_response},
    {1 <<< 50, :user_confirmation_request},
    {1 <<< 51, :user_passkey_request},
    {1 <<< 52, :remote_oob_data_request},
    {1 <<< 53, :simple_pairing_complete},
    {1 <<< 55, :link_supervision_timeout_changed},
    {1 <<< 56, :enhanced_flush_complete},
    {1 <<< 58, :user_passkey_notification},
    {1 <<< 59, :keypress_notification},
    {1 <<< 60, :remote_host_supported_features_notification},
    {1 <<< 61, :le_meta}
  ]

  @doc false
  def default() do
    for {_bit_pos, key} <- @events_map, into: %{}, do: {key, 1}
  end

  @doc false
  @spec mask_events(map()) :: non_neg_integer()
  def mask_events(events) when is_map(events) do
    Enum.reduce(@events_map, 0, fn {value, key}, acc ->
      if Map.get(events, key) do
        acc + value
      else
        acc
      end
    end)
  end

  @doc false
  @spec unmask_events(non_neg_integer()) :: keyword()
  def unmask_events(events) do
    for {value, key} <- @events_map do
      {key, (events &&& value) != 0}
    end
  end
end
