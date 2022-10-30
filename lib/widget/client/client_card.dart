import 'package:appointments/data_types/components.dart';
import 'package:appointments/providers/clients_mgr.dart';
import 'package:appointments/screens/home/clients/client_details.dart';
import 'package:appointments/widget/custom/custom_avatar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:common_widgets/custom_list_tile.dart';
import 'package:common_widgets/ease_in_animation.dart';
import 'package:common_widgets/utils/layout.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ClientCard extends StatelessWidget {
  final ClientCardProps clientCardProps;
  const ClientCard({
    Key? key,
    required this.clientCardProps,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future<ImageProvider<Object>?> getClientImage(String path) async {
      String imageUrl = '';
      if (path.isNotEmpty) {
        final clientsMgr = Provider.of<ClientsMgr>(context, listen: false);
        imageUrl = await clientsMgr.getClientImage(path);
      }
      if (imageUrl.isNotEmpty) {
        return CachedNetworkImageProvider(imageUrl);
      }
      return null;
    }

    navigateToClientDetails(Client client) {
      final clientsMgr = Provider.of<ClientsMgr>(context, listen: false);
      clientsMgr.setSelectedClient(client: client);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ClientDetails(),
        ),
      );
    }

    return CustomListTile(
      customListTileProps: CustomListTileProps(
        enabled: clientCardProps.enabled,
        onTap: clientCardProps.onTap ??
            () => navigateToClientDetails(clientCardProps.contactDetails),
        title: Text(
          clientCardProps.contactDetails.fullName,
          style: Theme.of(context).textTheme.headline1?.copyWith(
                fontSize: rSize(16),
              ),
        ),
        subTitle: Padding(
          padding: EdgeInsets.only(
            top: rSize(2),
          ),
          child: Text(
            clientCardProps.contactDetails.phone,
            style: Theme.of(context).textTheme.subtitle1?.copyWith(
                  fontSize: rSize(14),
                ),
          ),
        ),
        trailing: Row(
          children: [
            clientCardProps.withNavigation
                ? IconTheme(
                    data: Theme.of(context).primaryIconTheme,
                    child: Icon(
                      Icons.chevron_right,
                      size: rSize(25),
                    ),
                  )
                : const SizedBox(),
            clientCardProps.withDelete
                ? EaseInAnimation(
                    onTap: clientCardProps.onCloseTap ?? () => {},
                    child: IconTheme(
                      data: Theme.of(context).primaryIconTheme,
                      child: Icon(
                        Icons.close,
                        size: rSize(25),
                      ),
                    ),
                  )
                : const SizedBox(),
          ],
        ),
        leading: FutureBuilder<ImageProvider<Object>?>(
            future: getClientImage(
              clientCardProps.contactDetails.imagePath,
            ),
            builder: (context, snapshot) {
              return CustomAvatar(
                customAvatarProps: CustomAvatarProps(
                  radius: rSize(50),
                  rectangleShape: true,
                  circleShape: false,
                  backgroundImage: snapshot.data,
                  defaultImage: const AssetImage(
                    'assets/images/avatar_female.png',
                  ),
                  enable: false,
                ),
              );
            }),
      ),
    );
  }
}

class ClientCardProps {
  final Client contactDetails;
  final bool withNavigation;
  final bool withDelete;
  final bool enabled;
  final Function? onTap;
  final Function? onCloseTap;

  ClientCardProps({
    required this.contactDetails,
    this.withNavigation = true,
    this.withDelete = false,
    this.enabled = true,
    this.onTap,
    this.onCloseTap,
  });
}
