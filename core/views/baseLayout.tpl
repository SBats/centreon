<!DOCTYPE html>
<html>
<head>
    <title>{block name="title"}{/block} - Centreon : IT Monitoring</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="icon" href="{url_static url='/centreon/img/centreonFavicon.ico'}" type="image/x-icon">
    {foreach from=$cssFileList item='cssFile'}
    {$cssFile|css}
    {/foreach}
    {block name="style-head"}{/block}
</head>

<body class="full-height-layout bodyCntr">
    <div id="notif-danger"></div>

<div class="mainCntr" id="mainCntr"> <!-- Wrapper -->

    <!-- Menu aside -->
    <nav class="navbar-default navbarSide navbar-static-side" role="navigation">
        <div class="sidebar-collapse">
            <ul class="nav" id="side-menu">
                <li class="logo">
                    <!--<a href="{get_user_homepage}" class="navbar-brand">{block name="appname"}<i class="fa fa-cube"></i> Centreon{/block}</a>-->
                    <div class="navbar-header">
                        <a class="navbar-minimalize minimalize-styl-2" href="#">
                            <img src="{url_static url='centreon/img/icons/ico-centreon.svg'}" alt="Centreon" />
                            <span class="nav-label">Centreon</span> </a>
                    </div>
                </li>
                    {foreach $appMenu as $menuLevel1}
                           <li>
                                {if $menuLevel1.url != ""}
                                    <a href="{url_for url=$menuLevel1.url}">
                                {else}
                                    <a href="#">
                                {/if}
                                    <i class="{$menuLevel1.icon_class}"></i>
                                        <span class="nav-label">{$menuLevel1.name}</span>
                                        {if count($menuLevel1.children) > 0}
                                            <span class="fa arrow"></span>
                                        {/if}
                                </a>
                                {if count($menuLevel1.children) > 0}
                                <ul class="nav nav-second-level">
                                    {foreach $menuLevel1.children as $menuLevel2}
                                    <li>
                                        {if $menuLevel2.url != ""}
                                            <a href="{url_for url=$menuLevel2.url}">
                                        {else}
                                            <a href="#">
                                        {/if}
                                            {$menuLevel2.name}
                                            {if count($menuLevel2.children) > 0}
                                                <span class="fa arrow"></span>
                                            {/if}
                                        </a>
                                        {if count($menuLevel2.children) > 0}
                                        <ul class="nav nav-third-level">
                                            {foreach $menuLevel2.children as $menuLevel3}
                                                <li>
                                                    {if $menuLevel3.url != ""}
                                                        <a href="{url_for url=$menuLevel3.url}">
                                                    {else}
                                                        <a href="#">
                                                    {/if}
                                                    {$menuLevel3.name}</a>
                                                </li>
                                            {/foreach}
                                        </ul>
                                        {/if}
                                    </li>
                                    {/foreach}
                                </ul>
                                {/if}
                           </li>
                    {/foreach}
                </li>
                <li class="landing_link" >
                    <a href="#"><i class="fa fa-star"></i> <span class="nav-label">Bookmark</span></a>
                    <ul id="myBookmark" class="nav nav-second-level"></ul>
                </li>

                {hook name='displayLeftMenu' container='<li>[hook]</li>'}
            </ul>
        </div>
    </nav>

    <div class="container-fluid viewCntr" id="pageWrapper"> <!-- Page Wrapper -->

        <div class="row">
            <nav class="navbar-default navbar-static-top GlobalNavbar">

                    <ul class="userProfil nav navbar-right">
                        <li class="dropdown">
                             <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">
                                <img src="{url_static url='/centreon/img/default-ico-user.png'}" alt="User Avatar">
                             </a>
                             <ul class="dropdown-menu profilSubmenu" role="menu">
                                <li>
                                   <div class="media">
                                     <div class="media-left media-middle">
                                       <a href="#">
                                         <img src="{url_static url='/centreon/img/avatar.png'}" alt="User avatar" style="width: 60px; height: 60px;">
                                       </a>
                                     </div>
                                     <div class="media-body">
                                       {if isset($userName)}
                                        <strong>{$userName}</strong>
                                       {/if}
                                       {if isset($userEmails)}
                                        {foreach $userEmails as $userEmail}
                                          <p><small>{$userEmail}</small></p>
                                        {/foreach}
                                       {/if}
                                        <ul class="list-unstyled list-inline ">
                                            <li>
                                                <a href="#" id="help">{t}Help{/t}</a>
                                            </li>
                                            <li>
                                                <a href="#" id="logout">{t}Logout{/t}</a>
                                            </li>
                                        </ul>

                                     </div>
                                   </div>
                                </li>
                                <li>
                                    <ul class="list-unstyled adminList">
                                        <li><a href="#">{t}Edit Profile{/t}</a></li>
                                        <li><a href="#">{t}Settings{/t}</a></li>
                                        <li>{environment_user}</li>
                                    </ul>
                                </li>
                             </ul>
                         </li>
                    </ul>                     
                    <ul class="timeZone nav navbar-right">
                        <li class="time">                                  
                            <a class="account dropdown-toggle" data-toggle="dropdown" href="#"><span class="clock"></span></a>
                            <a href="#" id="undotimezone" onclick="changeTimezone();"><span class="fa fa-undo"></span></a>
                            <ul class="dropdown-menu" id="list_timezone">
                                <li ><a href="#" id="modalAdd_timezone">{t}Add horloge{/t}<i class="fa fa-clock-o"></i></a></li>
                            </ul>
                         </li>
                    </ul>
                    <ul class="indicators nav navbar-right">
                        <li class="top-counter top-counter-critical">
                             <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                               <i class="icon-fill-critical-incident ico-24">
                                <span class="path1"></span><span class="path2"></span><span class="path3"></span>
                               </i>
                             </a>
                             <div class="indicWrapper">
                                <div class="titles">
                                    <p>incidents</p>
                                    <p>impacts</p>
                                </div>
                                <div class="indices">
                                    <span class="icon-fill-host ico-16"></span> <span class="danger">N/A</span>
                                    <span class="icon-fill-service ico-16"></span> <span class="danger"> N/A</span>
                                    <br>
                                    <span> N/A</span>
                                </div>
                             </div>
                             <div class="dropdown-menu issuesPopover">
                                <ul>
                                    <li>
                                        <h5>Hosts</h5>
                                        <p><span class="danger">N/A </span> / N/A</p>
                                    </li>
                                    <li>
                                        <h6><span class="icon-host ico-16"></span> Host 1</h6>
                                        <p><span class="duration">1h50</span></p>
                                    </li>
                                     <li>
                                        <h6><span class="icon-host ico-16"></span> Host 2</h6>
                                        <p><span class="duration">1h50</span></p>
                                     </li>
                                     <li>
                                        <h6><span class="icon-host ico-16"></span> Host 3</h6>
                                        <p><span class="duration">1h50</span></p>
                                    </li>
                                    <li>
                                        <h6><span class="icon-host ico-16"></span> Host 3</h6>
                                        <p><span class="duration">1h50</span></p>
                                    </li>
                                    <li>
                                        <h6><span class="icon-host ico-16"></span> Host 3</h6>
                                        <p><span class="duration">1h50</span></p>
                                    </li>
                                    <li>
                                        <p><a href="#" title="more"><span class="icon-plus ico-16"></span></a></p>
                                    </li>
                                </ul>
                                <ul>
                                    <li>
                                        <h5>Services</h5>
                                        <p><span class="danger">50 </span> / 256</p>
                                    </li>
                                    <li>
                                        <h6><span class="icon-service ico-16"></span> Service 1</h6>
                                        <p><span class="duration">1h50</span></p>
                                    </li>
                                     <li>
                                        <h6><span class="icon-service ico-16"></span> Service 2</h6>
                                        <p><span class="duration">1h50</span></p>
                                     </li>
                                     <li>
                                        <h6><span class="icon-service ico-16"></span> Service 3</h6>
                                        <p><span class="duration">1h50</span></p>
                                    </li>
                                    <li>
                                        <h6><span class="icon-service ico-16"></span> Service 3</h6>
                                        <p><span class="duration">1h50</span></p>
                                    </li>
                                    <li>
                                        <h6><span class="icon-service ico-16"></span> Service 3</h6>
                                        <p><span class="duration">1h50</span></p>
                                    </li>
                                    <li>
                                        <p><a href="#" title="more"><span class="icon-plus ico-16"></span></a></p>
                                    </li>
                                </ul>
                             </div>
                         </li>
                         <li class="top-counter top-counter-warning">
                              <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                                <i class="icon-fill-incident ico-24">
                                  <span class="path1"></span><span class="path2"></span><span class="path3"></span>
                                </i>
                              </a>
                              <div class="indicWrapper">
                                  <div class="titles">
                                      <p>incidents</p>
                                      <p>impacts</p>
                                  </div>
                                  <div class="indices">
                                      <span class="warning">N/A</span>
                                      <br>
                                      <span> N/A</span>
                                  </div>
                               </div>
                              <span class="label label-warning hide"></span>

                              <div class="dropdown-menu issuesPopover">
                                  <ul>
                                       <li>
                                          <h5>Services</h5>
                                          <p><span class="danger">N/A </span> / N/A</p>
                                      </li>
                                      <li>
                                          <h6><span class="icon-service ico-16"></span> Service 1</h6>
                                          <p><span class="duration">1h50</span></p>
                                      </li>
                                       <li>
                                          <h6><span class="icon-service ico-16"></span> Service 2</h6>
                                          <p><span class="duration">1h50</span></p>
                                       </li>
                                       <li>
                                          <h6><span class="icon-service ico-16"></span> Service 3</h6>
                                          <p><span class="duration">1h50</span></p>
                                      </li>
                                      <li>
                                          <h6><span class="icon-service ico-16"></span> Service 3</h6>
                                          <p><span class="duration">1h50</span></p>
                                      </li>
                                      <li>
                                          <h6><span class="icon-service ico-16"></span> Service 3</h6>
                                          <p><span class="duration">1h50</span></p>
                                      </li>
                                      <li>
                                          <p><a href="#" title="more"><span class="icon-plus ico-16"></span></a></p>
                                      </li>
                                  </ul>
                              </div>
                          </li>

                          <li class="top-counter top-counter-unknown">
                            <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                              <i class="icon-fill-unknown-incident ico-24">
                                <span class="path1"></span><span class="path2"></span><span class="path3"></span>
                              </i>
                            </a>

                            <div class="indicWrapper">
                                <div class="titles">
                                    <p>pending</p>
                                    <p>unknown</p>
                                </div>
                                <div class="indices">
                                    <span class="icon-fill-host ico-16"></span> <span class="danger">0</span>
                                    <span class="icon-fill-service ico-16"></span> <span class="danger"> 0</span>
                                    <br>
                                    <span> 0</span>
                                    <span> 0</span>
                                </div>
                             </div>

                             
                            <span class="label label-default hide"></span>
                            <div class="dropdown-menu issuesPopover">

                                <ul>
                                    <li>
                                        <h6><span class="icon-fill-host ico-16"></span>| Pending</h6>
                                        <p><span class="danger">N/A </span> / N/A</p>
                                    </li>
                                    <li>
                                        <h6><span class="icon-host ico-16"></span> Host 1</h6>
                                        <p><span class="duration">1h50</span></p>
                                    </li>
                                     <li>
                                        <h6><span class="icon-host ico-16"></span> Host 2</h6>
                                        <p><span class="duration">1h50</span></p>
                                     </li>
                                     <li>
                                        <h6><span class="icon-host ico-16"></span> Host 3</h6>
                                        <p><span class="duration">1h50</span></p>
                                    </li>
                                    <li>
                                        <p><a href="#" title="more"><span class="icon-plus ico-16"></span></a></p>
                                    </li>
                                </ul>
                                <ul>
                                    <li>
                                        <h6><span class="icon-fill-host ico-16"></span>| Unrea.</h6>
                                        <p><span class="danger">N/A </span> / N/A</p>
                                    </li>
                                    <li>
                                        <h6><span class="icon-host ico-16"></span> Host 1</h6>
                                        <p><span class="duration">1h50</span></p>
                                    </li>
                                     <li>
                                        <h6><span class="icon-host ico-16"></span> Host 2</h6>
                                        <p><span class="duration">1h50</span></p>
                                     </li>
                                     <li>
                                        <h6><span class="icon-host ico-16"></span> Host 3</h6>
                                        <p><span class="duration">1h50</span></p>
                                    </li>
                                    <li>
                                        <p><a href="#" title="more"><span class="icon-plus ico-16"></span></a></p>
                                    </li>
                                </ul>
                                <ul>
                                    <li>
                                        <h6><span class="icon-fill-service ico-16"></span>| Pending</h6>
                                        <p><span class="danger">N/A </span> / N/A</p>
                                    </li>
                                    <li>
                                        <h6><span class="icon-service ico-16"></span> Service 1</h6>
                                        <p><span class="duration">1h50</span></p>
                                    </li>
                                     <li>
                                        <h6><span class="icon-service ico-16"></span> Service 2</h6>
                                        <p><span class="duration">1h50</span></p>
                                     </li>
                                    <li>
                                        <h6><span class="icon-service ico-16"></span> Service 3</h6>
                                        <p><span class="duration">1h50</span></p>
                                    </li>
                                    <li>
                                        <p><a href="#" title="more"><span class="icon-plus ico-16"></span></a></p>
                                    </li>
                                </ul>
                                <ul>
                                    <li>
                                        <h6><span class="icon-fill-service ico-16"></span>| Uncknown</h6>
                                        <p><span class="danger">N/A </span> / N/A</p>
                                    </li>
                                    <li>
                                        <h6><span class="icon-service ico-16"></span> Service 1</h6>
                                        <p><span class="duration">1h50</span></p>
                                    </li>
                                     <li>
                                        <h6><span class="icon-service ico-16"></span> Service 2</h6>
                                        <p><span class="duration">1h50</span></p>
                                     </li>
                                    <li>
                                        <h6><span class="icon-service ico-16"></span> Service 3</h6>
                                        <p><span class="duration">1h50</span></p>
                                    </li>
                                    <li>
                                        <p><a href="#" title="more"><span class="icon-plus ico-16"></span></a></p>
                                    </li>
                                </ul>
                             </div>
                          </li>

                        <li class="top-counter top-counter-poller">

                            <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                                <span class="icon-fill-poller ico-24"></span>
                            </a>
                            <div class="indicWrapper">
                                  <div class="titles">
                                      <p>stopped</p>
                                      <p>unreach.</p>
                                  </div>
                                  <div class="indices">
                                      <span> N/A</span>
                                      <br>
                                      <span> N/A</span>
                                  </div>
                            </div>

                        </li>

                        <li class="top-counter top-counter-ba">
                            <a href="#" class="dropdown-toggle drop-avatar" data-toggle="dropdown">
                                <span class="icon-fill-BA ico-24"><span class="path1"></span><span class="path2"></span><span class="path3"></span><span class="path4"></span><span class="path5"></span></span>
                            </a>

                            <div class="indicWrapper">
                                  <div class="titles">
                                      <p>not perf.</p>
                                      <p>not avail.</p>
                                  </div>
                                  <div class="indices">
                                      <span> N/A</span>
                                      <br>
                                      <span> N/A</span>
                                  </div>
                            </div>

                            <span class="label label-danger hide"></span>
                            <span class="label label-warning hide"></span>
                            <div class="dropdown-menu issuesPopover">
                              <ul>
                                   <li>
                                      <h5>Services</h5>
                                      <p><span class="danger">50 </span> / 256</p>
                                  </li>
                                  <li>
                                      <h6><span class="icon-service ico-16"></span> Service 1</h6>
                                      <p><span class="duration">1h50</span></p>
                                  </li>
                                   <li>
                                      <h6><span class="icon-service ico-16"></span> Service 2</h6>
                                      <p><span class="duration">1h50</span></p>
                                   </li>
                                   <li>
                                      <h6><span class="icon-service ico-16"></span> Service 3</h6>
                                      <p><span class="duration">1h50</span></p>
                                  </li>
                                  <li>
                                      <h6><span class="icon-service ico-16"></span> Service 3</h6>
                                      <p><span class="duration">1h50</span></p>
                                  </li>
                                  <li>
                                      <h6><span class="icon-service ico-16"></span> Service 3</h6>
                                      <p><span class="duration">1h50</span></p>
                                  </li>
                                  <li>
                                      <p><a href="#" title="more"><span class="icon-plus ico-16"></span></a></p>
                                  </li>
                              </ul>
                             </div>
                        </li>
                    </ul>
            </nav>
        </div>

        <div id="contentWrapper" class="contentWrapper full-height">
            <div class="full-height-scroll">{block name="content"}{/block}</div>
        </div>

        <div class="bottombar">
            <div  class="footer_links col-sm-8 col-md-4">
                <a href="http://documentation.centreon.com/" data-toggle="tooltip" data-placement="top" title="{t}Documentation{/t}"><i class="fa fa-book"></i></a>
                <a href="https://github.com/centreon/centreon" data-toggle="tooltip" data-placement="top" title="{t}Source{/t}"><i class="fa fa-github"></i></a>
                <a href="http://forge.centreon.com" data-toggle="tooltip" data-placement="top" title="{t}Forge{/t}"><i class="fa fa-inbox"></i></a>
                <a href="https://plus.google.com/u/0/s/centreon"  data-toggle="tooltip" data-placement="top" title="{t}Google +{/t}"><i class="fa fa-google-plus-square"></i></a>
                <a href="https://twitter.com/Centreon" data-toggle="tooltip" data-placement="top" title="{t}Twitter{/t}"><i class="fa fa-twitter"></i></a>
                <a href="https://www.facebook.com/pages/Centreon/157748944280967" data-toggle="tooltip" data-placement="top" title="{t}Facebook{/t}"><i class="fa fa-facebook"></i></a>
                <a href="http://forge.centreon.com/projects/centreon/issues/new" data-toggle="tooltip" data-placement="top" title="{t}Bug ?{/t}"><i class="fa fa-bug"></i></a>
                <a href="http://www.centreon.com/" data-toggle="tooltip" data-placement="top" title="{t}Web{/t}"><i class="fa fa-desktop"></i></a>
            </div>

            <p class="signature col-sm-4 col-md-4 col-md-offset-4"> <a href="http://www.centreon.com/">Centreon </a><small>Beta</small> &copy; 2005-2015</p>
        </div>

       <div class="modal fade" id="modal" role="dialog" aria-labelledby="wizard" aria-hidden="true">
           <div class="modal-dialog modal-lg">
               <div class="modal-content"></div>
           </div>
       </div>
    </div>

    {foreach from=$jsBottomFileList item='jsFile'}
    {$jsFile|js}
    {/foreach}
    <script>
        var formValidRule = {};
        $(document).ready(function() {
            var statusInterval, statusData,
                eStatus = new $.Event('centreon.refresh_status');
            $('.btn-light').on('click', function() {
                switchTheme('light');
            });
            $('.btn-dark').on('click', function() {
                switchTheme('dark');
            });

            $('#logout').on('click', function(e) {
                e.preventDefault();
                e.stopPropagation();
                $.ajax({
                    url: "{url_for url='/logout'}",
                    type: "GET",
                    success: function(data, textStatus, jqXHR) {
                        if(!isJson(data)){
                            alertMessage( "{t} An Error Occured {/t}", "alert-danger" );
                            return false;
                         }
                        
                        if ( data.success ) {
                            if (data.status) {
                                window.location.href = "{url_for url='/login'}";
                            }
                        }else{
                            alertMessage( "{t} An Error Occured {/t}", "alert-danger" );
                        }
                        
                    }
                });
            });


            $("body").on("click", "#modalAdd_timezone", function(e) {
                $("#modal").removeData("bs.modal");
                $("#modal").removeData("centreonWizard");
                $("#modal .modal-content").text("");
                $("#modal").one("loaded.bs.modal", function(e) {
                    $(this).centreonWizard();
                });
                $("#modal").modal({
                    "remote": "{url_for url='/centreon-administration/timezone/addtouser'}"
                });
            });

             $(document).on('click', '.modalDelete', function(e) {
                e.preventDefault();
                $('#modal .modal-content').text('');
                var id = $(this).data('id');

                /* Delete modal header */
                var $deleteHeader = $('<div></div>').addClass('modal-header');
                $('<button></button>')
                    .attr('type', 'button')
                    .attr('aria-hidden', 'true')
                    .attr('data-dismiss', 'modal')
                    .addClass('close')
                    .html('&times;')
                    .appendTo($deleteHeader);
                $('<h4></h4>').addClass('modal-title').text("{t}Delete{/t}").appendTo($deleteHeader);
                $deleteHeader.appendTo('#modal .modal-content');

                /* Delete modal body */
                var $deleteBody = $('<div></div>').addClass('modal-body');
                $('<span></span>').text('{t}Are you sure to delete ?{/t}').appendTo($deleteBody);
                var $listElement = $('<ul></ul>').addClass('list-unstyled');
                $('table[id^="datatable"] tbody tr[class*="selected"]').each(function(k, v) {
                    $('<li></li>').html($(v).data('name')).appendTo($listElement);
                });
                $listElement.appendTo($deleteBody);
                $deleteBody.appendTo('#modal .modal-content');

                var $deleteFooter = $('<div></div>').addClass('modal-footer');
                $('<a></a>')
                    .attr('aria-hidden', 'true')
                    .attr('data-dismiss', 'modal')
                    .addClass('btnC').addClass('btnDefault')
                    .text('{t}Cancel{/t}')
                    .appendTo($deleteFooter);
                var $deleteBtn = $('<button></button>')
                    .attr('type', 'button')
                    .addClass('btnC')
                    .addClass('btnDanger')
                    .text('{t}Delete{/t}')
                    .appendTo($deleteFooter);
                $deleteFooter.appendTo('#modal .modal-content');

                var objectDeleteUrl =  "{url_for url='/centreon-administration/user/deletetimezone'}";

                $deleteBtn.on('click', function(e) {
                    $.ajax({
                        url: objectDeleteUrl,
                        type: 'POST',
                        data: {
                            'id': id
                        },
                        dataType: 'json',
                        success: function(data, textStatus, jqXHR) {
                            if(!isJson(data)){
                                alertMessage( "{t} An Error Occured {/t}", "alert-danger" );
                                return false;
                            }
                            $('#modal').modal('hide');
                            alertClose();
                            if (data.success) {
                                oTable.fnDraw();
                                alertMessage('{t}The objects have been successfully deleted{/t}', 'notif-success', 3);
                            } else {
                                alertMessage(data.errorMessage, 'notif-danger');
                            }
                        }
                    });
                });

                 $('#modal')
                    .removeData('bs.modal')
                    .modal();
            });

            function loadStatusData() {
              $.ajax({
                url: "{url_for url='/status'}",
                type: 'GET',
                success: function(data, textStatus, jqXHR) {
                    
                    if(!isJson(data)){
                        alertMessage( "{t} An Error Occured {/t}", "alert-danger" );
                        return false;
                    }
                    if ( data.success ) {
                        statusData = data;
                        $(document).trigger(eStatus);
                    }else{
                        alertMessage( "{t}An Error Occured {/t}", "alert-danger" );
                    }
                  
                }
              });
            }

            /* Timer */
            topClock();
            
            {if isset($jsUrl)}
                var jsUrl = {$jsUrl|json_encode};
            {else}
                var jsUrl = {};
            {/if}

                loadBookmark('{url_for url="/bookmark/list"}');

              /* Init tooltips */
              $( ".bottombar a" ).tooltip();

              paceOptions = {
                // Configuration goes here. Example:
                elements: false,
                restartOnPushState: false,
                restartOnRequestAfter: false
              };

            {hook name='displayJsStatus' container='[hook]'}

            statusInterval = setInterval(function() {
                loadStatusData();
            }, 5000);
            loadStatusData();

        });
    </script>
    {block name="javascript-bottom"}
    <script>{get_custom_js}</script>
    {/block}
</div>
</body>
</html>
