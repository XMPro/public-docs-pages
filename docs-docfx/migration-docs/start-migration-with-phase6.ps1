# Main execution
function Start-Migration {
    Write-Log "Starting navigation migration script" -Level "INFO"
    
    # Initialize state
    Initialize-State
    
    # Execute phases based on current state
    switch ($script:state.phase) {
        0 {
            Write-Log "Starting migration from the beginning..." -Level "INFO"
            $script:state.phase = 1
            $script:state.completed = $false
            Save-State
            if (Execute-Phase1) {
                Write-Log "Phase 1 completed successfully. Moving to Phase 2." -Level "SUCCESS"
                $script:state.phase = 2
                $script:state.completed = $false
                Save-State
                if (Execute-Phase2) {
                    Write-Log "Phase 2 completed successfully. Moving to Phase 3." -Level "SUCCESS"
                    $script:state.phase = 3
                    $script:state.completed = $false
                    Save-State
                    if (Execute-Phase3) {
                        Write-Log "Phase 3 completed successfully. Moving to Phase 4." -Level "SUCCESS"
                        $script:state.phase = 4
                        $script:state.completed = $false
                        Save-State
                        if (Execute-Phase4) {
                            Write-Log "Phase 4 completed successfully. Moving to Phase 5." -Level "SUCCESS"
                            $script:state.phase = 5
                            $script:state.completed = $false
                            Save-State
                            if (Execute-Phase5) {
                                Write-Log "Phase 5 completed successfully. Moving to Phase 6." -Level "SUCCESS"
                                $script:state.phase = 6
                                $script:state.completed = $false
                                Save-State
                                if (Execute-Phase6) {
                                    Write-Log "Phase 6 completed successfully." -Level "SUCCESS"
                                    Write-Log "Use cases content migration complete." -Level "SUCCESS"
                                    Write-Log "To continue with the next phases, run this script again." -Level "INFO"
                                }
                            }
                        }
                    }
                }
            }
        }
        1 {
            if (-not $script:state.completed) {
                Write-Log "Resuming Phase 1: Create Base Directory Structure..." -Level "INFO"
                if (Execute-Phase1) {
                    Write-Log "Phase 1 completed successfully. Moving to Phase 2." -Level "SUCCESS"
                    $script:state.phase = 2
                    $script:state.completed = $false
                    Save-State
                    if (Execute-Phase2) {
                        Write-Log "Phase 2 completed successfully. Moving to Phase 3." -Level "SUCCESS"
                        $script:state.phase = 3
                        $script:state.completed = $false
                        Save-State
                        if (Execute-Phase3) {
                            Write-Log "Phase 3 completed successfully. Moving to Phase 4." -Level "SUCCESS"
                            $script:state.phase = 4
                            $script:state.completed = $false
                            Save-State
                            if (Execute-Phase4) {
                                Write-Log "Phase 4 completed successfully. Moving to Phase 5." -Level "SUCCESS"
                                $script:state.phase = 5
                                $script:state.completed = $false
                                Save-State
                                if (Execute-Phase5) {
                                    Write-Log "Phase 5 completed successfully. Moving to Phase 6." -Level "SUCCESS"
                                    $script:state.phase = 6
                                    $script:state.completed = $false
                                    Save-State
                                    if (Execute-Phase6) {
                                        Write-Log "Phase 6 completed successfully." -Level "SUCCESS"
                                        Write-Log "Use cases content migration complete." -Level "SUCCESS"
                                        Write-Log "To continue with the next phases, run this script again." -Level "INFO"
                                    }
                                }
                            }
                        }
                    }
                }
            }
            else {
                Write-Log "Phase 1 already completed. Moving to Phase 2..." -Level "INFO"
                $script:state.phase = 2
                $script:state.completed = $false
                Save-State
                if (Execute-Phase2) {
                    Write-Log "Phase 2 completed successfully. Moving to Phase 3." -Level "SUCCESS"
                    $script:state.phase = 3
                    $script:state.completed = $false
                    Save-State
                    if (Execute-Phase3) {
                        Write-Log "Phase 3 completed successfully. Moving to Phase 4." -Level "SUCCESS"
                        $script:state.phase = 4
                        $script:state.completed = $false
                        Save-State
                        if (Execute-Phase4) {
                            Write-Log "Phase 4 completed successfully. Moving to Phase 5." -Level "SUCCESS"
                            $script:state.phase = 5
                            $script:state.completed = $false
                            Save-State
                            if (Execute-Phase5) {
                                Write-Log "Phase 5 completed successfully. Moving to Phase 6." -Level "SUCCESS"
                                $script:state.phase = 6
                                $script:state.completed = $false
                                Save-State
                                if (Execute-Phase6) {
                                    Write-Log "Phase 6 completed successfully." -Level "SUCCESS"
                                    Write-Log "Use cases content migration complete." -Level "SUCCESS"
                                    Write-Log "To continue with the next phases, run this script again." -Level "INFO"
                                }
                            }
                        }
                    }
                }
            }
        }
        2 {
            if (-not $script:state.completed) {
                Write-Log "Resuming Phase 2: Create TOC Files for Main Sections..." -Level "INFO"
                if (Execute-Phase2) {
                    Write-Log "Phase 2 completed successfully. Moving to Phase 3." -Level "SUCCESS"
                    $script:state.phase = 3
                    $script:state.completed = $false
                    Save-State
                    if (Execute-Phase3) {
                        Write-Log "Phase 3 completed successfully. Moving to Phase 4." -Level "SUCCESS"
                        $script:state.phase = 4
                        $script:state.completed = $false
                        Save-State
                        if (Execute-Phase4) {
                            Write-Log "Phase 4 completed successfully. Moving to Phase 5." -Level "SUCCESS"
                            $script:state.phase = 5
                            $script:state.completed = $false
                            Save-State
                            if (Execute-Phase5) {
                                Write-Log "Phase 5 completed successfully. Moving to Phase 6." -Level "SUCCESS"
                                $script:state.phase = 6
                                $script:state.completed = $false
                                Save-State
                                if (Execute-Phase6) {
                                    Write-Log "Phase 6 completed successfully." -Level "SUCCESS"
                                    Write-Log "Use cases content migration complete." -Level "SUCCESS"
                                    Write-Log "To continue with the next phases, run this script again." -Level "INFO"
                                }
                            }
                        }
                    }
                }
            }
            else {
                Write-Log "Phase 2 already completed. Moving to Phase 3..." -Level "INFO"
                $script:state.phase = 3
                $script:state.completed = $false
                Save-State
                if (Execute-Phase3) {
                    Write-Log "Phase 3 completed successfully. Moving to Phase 4." -Level "SUCCESS"
                    $script:state.phase = 4
                    $script:state.completed = $false
                    Save-State
                    if (Execute-Phase4) {
                        Write-Log "Phase 4 completed successfully. Moving to Phase 5." -Level "SUCCESS"
                        $script:state.phase = 5
                        $script:state.completed = $false
                        Save-State
                        if (Execute-Phase5) {
                            Write-Log "Phase 5 completed successfully. Moving to Phase 6." -Level "SUCCESS"
                            $script:state.phase = 6
                            $script:state.completed = $false
                            Save-State
                            if (Execute-Phase6) {
                                Write-Log "Phase 6 completed successfully." -Level "SUCCESS"
                                Write-Log "Use cases content migration complete." -Level "SUCCESS"
                                Write-Log "To continue with the next phases, run this script again." -Level "INFO"
                            }
                        }
                    }
                }
            }
        }
        3 {
            if (-not $script:state.completed) {
                Write-Log "Resuming Phase 3: Create Index Files for Main Sections..." -Level "INFO"
                if (Execute-Phase3) {
                    Write-Log "Phase 3 completed successfully. Moving to Phase 4." -Level "SUCCESS"
                    $script:state.phase = 4
                    $script:state.completed = $false
                    Save-State
                    if (Execute-Phase4) {
                        Write-Log "Phase 4 completed successfully. Moving to Phase 5." -Level "SUCCESS"
                        $script:state.phase = 5
                        $script:state.completed = $false
                        Save-State
                        if (Execute-Phase5) {
                            Write-Log "Phase 5 completed successfully. Moving to Phase 6." -Level "SUCCESS"
                            $script:state.phase = 6
                            $script:state.completed = $false
                            Save-State
                            if (Execute-Phase6) {
                                Write-Log "Phase 6 completed successfully." -Level "SUCCESS"
                                Write-Log "Use cases content migration complete." -Level "SUCCESS"
                                Write-Log "To continue with the next phases, run this script again." -Level "INFO"
                            }
                        }
                    }
                }
            }
            else {
                Write-Log "Phase 3 already completed. Moving to Phase 4..." -Level "INFO"
                $script:state.phase = 4
                $script:state.completed = $false
                Save-State
                if (Execute-Phase4) {
                    Write-Log "Phase 4 completed successfully. Moving to Phase 5." -Level "SUCCESS"
                    $script:state.phase = 5
                    $script:state.completed = $false
                    Save-State
                    if (Execute-Phase5) {
                        Write-Log "Phase 5 completed successfully. Moving to Phase 6." -Level "SUCCESS"
                        $script:state.phase = 6
                        $script:state.completed = $false
                        Save-State
                        if (Execute-Phase6) {
                            Write-Log "Phase 6 completed successfully." -Level "SUCCESS"
                            Write-Log "Use cases content migration complete." -Level "SUCCESS"
                            Write-Log "To continue with the next phases, run this script again." -Level "INFO"
                        }
                    }
                }
            }
        }
        4 {
            if (-not $script:state.completed) {
                Write-Log "Resuming Phase 4: Create Year-Specific TOC and Index Files..." -Level "INFO"
                if (Execute-Phase4) {
                    Write-Log "Phase 4 completed successfully. Moving to Phase 5." -Level "SUCCESS"
                    $script:state.phase = 5
                    $script:state.completed = $false
                    Save-State
                    if (Execute-Phase5) {
                        Write-Log "Phase 5 completed successfully. Moving to Phase 6." -Level "SUCCESS"
                        $script:state.phase = 6
                        $script:state.completed = $false
                        Save-State
                        if (Execute-Phase6) {
                            Write-Log "Phase 6 completed successfully." -Level "SUCCESS"
                            Write-Log "Use cases content migration complete." -Level "SUCCESS"
                            Write-Log "To continue with the next phases, run this script again." -Level "INFO"
                        }
                    }
                }
            }
            else {
                Write-Log "Phase 4 already completed. Moving to Phase 5..." -Level "INFO"
                $script:state.phase = 5
                $script:state.completed = $false
                Save-State
                if (Execute-Phase5) {
                    Write-Log "Phase 5 completed successfully. Moving to Phase 6." -Level "SUCCESS"
                    $script:state.phase = 6
                    $script:state.completed = $false
                    Save-State
                    if (Execute-Phase6) {
                        Write-Log "Phase 6 completed successfully." -Level "SUCCESS"
                        Write-Log "Use cases content migration complete." -Level "SUCCESS"
                        Write-Log "To continue with the next phases, run this script again." -Level "INFO"
                    }
                }
            }
        }
        5 {
            if (-not $script:state.completed) {
                Write-Log "Resuming Phase 5: Migrate Blog Content..." -Level "INFO"
                if (Execute-Phase5) {
                    Write-Log "Phase 5 completed successfully. Moving to Phase 6." -Level "SUCCESS"
                    $script:state.phase = 6
                    $script:state.completed = $false
                    Save-State
                    if (Execute-Phase6) {
                        Write-Log "Phase 6 completed successfully." -Level "SUCCESS"
                        Write-Log "Use cases content migration complete." -Level "SUCCESS"
                        Write-Log "To continue with the next phases, run this script again." -Level "INFO"
                    }
                }
            }
            else {
                Write-Log "Phase 5 already completed. Moving to Phase 6..." -Level "INFO"
                $script:state.phase = 6
                $script:state.completed = $false
                Save-State
                if (Execute-Phase6) {
                    Write-Log "Phase 6 completed successfully." -Level "SUCCESS"
                    Write-Log "Use cases content migration complete." -Level "SUCCESS"
                    Write-Log "To continue with the next phases, run this script again." -Level "INFO"
                }
            }
        }
        6 {
            if (-not $script:state.completed) {
                Write-Log "Resuming Phase 6: Migrate Use Cases Content..." -Level "INFO"
                if (Execute-Phase6) {
                    Write-Log "Phase 6 completed successfully." -Level "SUCCESS"
                    Write-Log "Use cases content migration complete." -Level "SUCCESS"
                    Write-Log "To continue with the next phases, run this script again." -Level "INFO"
                }
            }
            else {
                Write-Log "Phase 6 already completed." -Level "INFO"
                Write-Log "Use cases content migration complete." -Level "SUCCESS"
                Write-Log "To continue with the next phases, run this script again." -Level "INFO"
            }
        }
        default {
            Write-Log "Phases 1-6 already completed. Future phases will be implemented in subsequent scripts." -Level "INFO"
            Write-Log "Current phase: $($script:state.phase)" -Level "INFO"
        }
    }
}

# Start the migration
Start-Migration
