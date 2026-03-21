function(ntrip_add_example target_name source_file)
  add_executable(${target_name} "${source_file}")
  target_link_libraries(${target_name} PRIVATE ntrip::ntrip)
endfunction()

if (NTRIP_BUILD_CASTER)
  ntrip_add_example(ntrip_caster_exam ntrip_caster_exam.cc)
endif()

if (NTRIP_BUILD_CLIENT)
  ntrip_add_example(ntrip_client_exam ntrip_client_exam.cc)
endif()

if (NTRIP_BUILD_SERVER)
  ntrip_add_example(ntrip_server_exam ntrip_server_exam.cc)
endif()

if (NTRIP_BUILD_CLIENT AND NTRIP_BUILD_SERVER)
  ntrip_add_example(
    ntrip_client_to_ntrip_server_exam
    ntrip_client_to_ntrip_server_exam.cc
  )
endif()
